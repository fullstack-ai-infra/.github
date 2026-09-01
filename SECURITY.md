# Security Policy

This is the organization-wide default for repositories that do not publish a
more specific security policy. An affected repository's local `SECURITY.md`
takes precedence for supported versions, scope, response targets, and contact
details.

## Report a vulnerability privately

Do not open a public issue, pull request, or discussion for a suspected
vulnerability.

GitHub private vulnerability reports and security advisories are scoped to a
repository rather than a general organization inbox. To report privately:

1. Identify the repository containing the affected code, configuration,
   artifact, or documentation.
2. Open that repository's **Security** tab.
3. Open **Advisories**, then select **Report a vulnerability**.
4. Submit the report only through that private form.

If the repository does not show **Report a vulnerability**, first follow any
repository-local security policy. If it inherits this policy and has no private
form, use the organization's
[confidential fallback inbox](https://github.com/bytefolk/.github/security/advisories/new)
and name every affected repository in the report. Do not include vulnerability
details in a public request.

For a vulnerability spanning several organization repositories, submit the
initial report to the repository with the primary impact and list the other
affected repositories privately. Maintainers will coordinate the response.

## Report contents

Include, when available:

- affected repositories, versions, commits, and components;
- impact and a realistic attack scenario;
- required configuration, access, or privileges;
- minimal reproduction steps or a proof of concept;
- suggested mitigation;
- whether the issue is already public; and
- whether anyone else has received the report.

Remove credentials, personal data, and third-party secrets from all evidence.
Use test accounts and the least destructive proof necessary.

## Coordinated disclosure

Maintainers will validate the report, determine affected scope, agree on
disclosure timing, and provide updates while remediation is in progress.
Repository-local policy may define more specific response targets.

Allow a reasonable remediation window before public disclosure. Reporters may
request credit; maintainers may withhold credit when legal, privacy, or safety
constraints require it.

## Safe research

Good-faith security research must:

- avoid accessing or changing data that is not yours;
- avoid service disruption, persistence, social engineering, and destructive
  testing;
- stop after demonstrating the minimum evidence required; and
- comply with applicable law.

Dependency vulnerabilities that do not affect an organization project should
be reported upstream. Exposed secrets belonging to an organization repository
are in scope and should be reported privately immediately.
