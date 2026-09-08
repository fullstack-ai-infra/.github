<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/bytefolk/.github/main/brand/bytefolk/symbol-reversed.svg">
    <img src="https://raw.githubusercontent.com/bytefolk/.github/main/brand/bytefolk/symbol.svg" alt="ByteFolk symbol" width="72" height="72">
  </picture>
</p>

<h1 align="center">ByteFolk</h1>

<p align="center">
  <strong>Your team. Your data. Your infrastructure.</strong><br>
  Open-source, self-hostable tools for people and AI agents to work together.
</p>

<p align="center">
  <a href="https://github.com/bytefolk/roleweave/releases/latest">Download RoleWeave</a> ·
  <a href="https://github.com/bytefolk/digital-employee-quickstart#try-a-case-safely">Try the CLI</a> ·
  <a href="https://github.com/bytefolk/.github/blob/main/profile/README.zh-CN.md">简体中文</a>
</p>

ByteFolk helps you organize AI employees, keep useful knowledge, and collaborate
on documents. Start with a desktop app or a portable CLI package, then add the
services your team needs.

## Start with your workflow

### Use a desktop workspace → [RoleWeave](https://github.com/bytefolk/roleweave)

Create a project, organize digital employees, and work with them through
role-based conversations. Keep the organization, documents, and task history
in one local workspace.

**Desktop preview available.** [macOS Apple Silicon](https://github.com/bytefolk/roleweave/releases/download/v0.1.1/roleweave-0.1.1-arm64.dmg) · [Windows x64](https://github.com/bytefolk/roleweave/releases/download/v0.1.1/roleweave-0.1.1-x64.exe) · [Release notes](https://github.com/bytefolk/roleweave/releases/tag/v0.1.1)

> The current v0.1.1 installers are for macOS Apple Silicon and Windows x64.
> They are not Apple Developer ID-signed/notarized or Windows Authenticode-signed;
> installation or first launch may show a security prompt. The default desktop
> host needs a locally installed Qoder CLI 1.1.x and working account access.

[Get started](https://github.com/bytefolk/roleweave#get-started) · [Latest release](https://github.com/bytefolk/roleweave/releases/latest)

### Build from the terminal → [Digital Employee](https://github.com/bytefolk/digital-employee)

Turn instructions, approved knowledge, and acceptance fixtures into reusable
employee packages. Validate a package locally, then run it with a supported,
configured Agent Host.

**Start without credentials:** [run an official example](https://github.com/bytefolk/digital-employee-quickstart#try-a-case-safely).
The quickstart pins a published CLI version and uses offline fixtures without
a model call. It checks the package contract; running real tasks requires a
configured AI host.

[CLI releases](https://github.com/bytefolk/digital-employee/releases/latest) · [Example library](https://github.com/bytefolk/digital-employee-quickstart#cases)

## Add the pieces you need

Each project has its own setup guide and can be explored independently.

| Project | What it helps you do | Start here |
| --- | --- | --- |
| [mem](https://github.com/bytefolk/mem) | Keep files, memories, and task checkpoints with their sources. | [MCP binaries](https://github.com/bytefolk/mem/releases/latest) · [Service setup](https://github.com/bytefolk/mem/blob/main/docs/RUN_LOCAL.md) |
| [doc](https://github.com/bytefolk/doc) | Write, share, and collaborate on documents with people and agents. | [Run locally](https://github.com/bytefolk/doc/blob/main/docs/RUN_LOCAL.md) |
| [design-system](https://github.com/bytefolk/design-system) | Build consistent interfaces with shared tokens and components. | [Developer guide](https://github.com/bytefolk/design-system#develop-and-verify) |

**Availability:** mem is experimental; its released MCP adapter needs a running
mem service. Its web/API setup is documented in the repository. doc and
design-system currently provide source setup guides and have no GitHub Releases.

[Ordane](https://github.com/bytefolk/ordane) hosts the source for a static marketing
site. For the available desktop application, use RoleWeave above.

## For developers and AI assistants

Use the repository that owns the capability you need:

- **Role packages and execution:** [Digital Employee CLI and contracts](https://github.com/bytefolk/digital-employee).
- **Desktop workflows and local automation:** [RoleWeave API reference](https://github.com/bytefolk/roleweave/blob/main/docs/api-contract-v0.md).
- **Files, memory, and retrieval:** [mem setup and interfaces](https://github.com/bytefolk/mem).
- **Document editing and collaboration:** [doc capabilities](https://github.com/bytefolk/doc/blob/main/docs/CAPABILITIES.md).

Check the installed version against its release notes before using an API or
claiming support. Source on `main` can be ahead of a published package. Keep
credentials in the configured service environment, outside prompts and
committed files. Local workspace storage does not mean offline model execution:
your configured AI host may send task content to its provider.

## Build with us

- **Try it:** download RoleWeave or follow the CLI quickstart above.
- **Report a problem:** open an issue in the project you used, with reproduction
  steps and redacted output. Never include tokens or private workspace data.
- **Contribute:** start with an issue, make a focused PR, and include reproducible
  checks. Changes go through CI and independent review.
- **Report a vulnerability:** use the affected repository's **Security** tab,
  not a public issue.

[Contributing](https://github.com/bytefolk/.github/blob/main/CONTRIBUTING.md) · [Governance](https://github.com/bytefolk/.github/blob/main/GOVERNANCE.md) · [Security](https://github.com/bytefolk/.github/blob/main/SECURITY.md) · [Support](https://github.com/bytefolk/.github/blob/main/SUPPORT.md) · [Code of Conduct](https://github.com/bytefolk/.github/blob/main/CODE_OF_CONDUCT.md)
