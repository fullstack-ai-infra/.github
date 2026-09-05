#!/usr/bin/env ruby

require "open3"
require "set"

GENERATED_PATH_SEGMENTS = %w[node_modules .venv venv dist build .next .cache coverage]

def run_git!(repo, *args)
  stdout, _stderr, status = Open3.capture3("git", "-C", repo, *args)
  return stdout if status.success?

  abort "local boundary check could not inspect the repository (git #{args.first} failed)"
end

def sensitive_path?(path)
  normalized = path.downcase
  segments = normalized.split("/")
  basename = File.basename(normalized)

  return false if segments.any? { |segment| GENERATED_PATH_SEGMENTS.include?(segment) }
  return false if %w[.env.example .env.sample].include?(basename)

  normalized.match?(%r{(^|/)(credentials?|secrets?|private|id_rsa|id_ed25519)(/|$)}) ||
    segments.any? { |segment| segment.start_with?(".env") && !segment.end_with?(".example") && !segment.end_with?(".sample") } ||
    %w[.npmrc .pypirc .netrc].include?(basename) ||
    normalized.match?(%r{\.(pem|key|p12|pfx|jks|keystore|tfstate|tfvars)(\.|$)})
end

abort "usage: ruby scripts/bytefolk-local-boundary-check.rb REPOSITORY" unless ARGV.length == 1

begin
  repo = File.realpath(ARGV.fetch(0))
rescue SystemCallError
  abort "local boundary check: repository path does not exist"
end

root = run_git!(repo, "rev-parse", "--show-toplevel").strip
root = File.realpath(root)
abort "local boundary check: pass one repository, not its parent" unless root == repo
abort "local boundary check: refusing the filesystem root" if root == "/"

tracked = run_git!(root, "ls-files", "-z").split("\0").reject(&:empty?)
untracked = run_git!(root, "ls-files", "--others", "--exclude-standard", "-z").split("\0").reject(&:empty?)
ignored = run_git!(root, "ls-files", "--others", "--ignored", "--exclude-standard", "-z").split("\0").reject(&:empty?)

tracked_sensitive = tracked.count { |path| sensitive_path?(path) }
untracked_sensitive = (untracked + ignored).count { |path| sensitive_path?(path) }

symlink_count = run_git!(root, "ls-files", "-s", "-z").split("\0").count do |record|
  record.start_with?("120000 ")
end

suspicious_patterns = [
  "-----BEGIN (RSA|EC|OPENSSH|DSA|PGP) PRIVATE KEY-----",
  "\\b(AKIA|ASIA)[0-9A-Z]{16}\\b",
  "\\b(LTAI|AKID)[A-Za-z0-9]{12,}\\b",
  "\\bgh[pousr]_[A-Za-z0-9_]{20,}\\b",
  "\\bgithub_pat_[A-Za-z0-9_]{20,}\\b",
  "\\bxox[baprs]-[A-Za-z0-9-]{20,}\\b"
]

suspicious_files = Set.new
suspicious_patterns.each do |pattern|
  stdout, _stderr, status = Open3.capture3(
    "git", "-C", root, "grep", "-I", "-i", "-l", "-E", pattern, "--"
  )
  suspicious_files.merge(stdout.split("\n")) if status.success?
end

puts "repository_files=#{tracked.length}"
puts "untracked_files=#{untracked.length}"
puts "ignored_files=#{ignored.length}"
puts "tracked_sensitive_names=#{tracked_sensitive}"
puts "untracked_or_ignored_sensitive_names=#{untracked_sensitive}"
puts "tracked_symlinks=#{symlink_count}"
puts "suspicious_content_files=#{suspicious_files.length}"

violations = tracked_sensitive + untracked_sensitive + symlink_count + suspicious_files.length
if violations.zero?
  puts "result=PASS"
  exit 0
end

puts "result=HOLD"
puts "details=suppressed; inspect locally without copying values into logs"
exit 1
