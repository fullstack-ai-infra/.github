# ByteFolk

> Your team. Your data. Your infrastructure.

ByteFolk builds open, self-hostable infrastructure for digital teams. We make
the local-first layer between AI models and real work: portable role packages,
an organization workspace, long-term memory, and collaborative documents.
Every project favors user-owned data, open interfaces, and claims backed by
reproducible evidence.

## Start here: [Digital&nbsp;Employee](https://github.com/fullstack-ai-infra/digital-employee)

[![Latest release](https://img.shields.io/github/v/release/fullstack-ai-infra/digital-employee?label=release)](https://github.com/fullstack-ai-infra/digital-employee/releases/latest) [![npm](https://img.shields.io/npm/v/%40fullstack-ai-infra%2Fdigital-employee?label=npm)](https://www.npmjs.com/package/@fullstack-ai-infra/digital-employee) [![CI](https://github.com/fullstack-ai-infra/digital-employee/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/fullstack-ai-infra/digital-employee/actions/workflows/ci.yml)

Package a role's instructions, approved knowledge, Schemas, and acceptance
fixtures as a portable digital employee. Validate it locally without a model
call, then run one-shot work through a configured, supported Agent Host.

**Try it without credentials:**
[run an official release-pinned case](https://github.com/fullstack-ai-infra/digital-employee-quickstart#try-a-case-safely).

[Quickstart](https://github.com/fullstack-ai-infra/digital-employee-quickstart) · [Latest release](https://github.com/fullstack-ai-infra/digital-employee/releases/latest) · [CLI and current status](https://github.com/fullstack-ai-infra/digital-employee#run) · [Roadmap](https://github.com/fullstack-ai-infra/digital-employee/blob/main/docs/roadmap.md)

> Digital Employee is under active development. The repositories distinguish
> public releases from source previews and planned capabilities; a green build
> or a merged change is not automatically a released feature.

## Explore the product stack

### [Digital&nbsp;Employee&nbsp;Quickstart](https://github.com/fullstack-ai-infra/digital-employee-quickstart) — official examples

**Release-pinned, credential-free starting point.** Try reusable employee
packages for team Q&A, onboarding, approval proposals, and product support.
Each case includes knowledge, Schemas, and offline acceptance fixtures.

[Try a case](https://github.com/fullstack-ai-infra/digital-employee-quickstart#try-a-case-safely) · [Browse examples](https://github.com/fullstack-ai-infra/digital-employee-quickstart#cases)

### [Org&nbsp;Workbench](https://github.com/fullstack-ai-infra/org-workbench) — local organization workspace

**Development preview; no tagged installer release yet.** An Electron desktop
workspace where the file tree is the org chart, with position-based local
conversations, auditable organization changes, and local reporting.

[Current status and source setup](https://github.com/fullstack-ai-infra/org-workbench) · [API contract](https://github.com/fullstack-ai-infra/org-workbench/blob/main/docs/api-contract-v0.md)

### [Memory](https://github.com/fullstack-ai-infra/mem) — portable memory plane

**Experimental; a public release is available.** Keep files, structured
memories, task checkpoints, and provenance under your control, with one core
available through API, MCP, CLI, and UI.

[Quick start](https://github.com/fullstack-ai-infra/mem#快速开始) · [Latest release](https://github.com/fullstack-ai-infra/mem/releases/latest) · [Product direction](https://github.com/fullstack-ai-infra/mem/blob/main/GOAL.md)

### [Docs](https://github.com/fullstack-ai-infra/doc) — collaborative document plane

**Experimental source preview; no tagged release yet.** Self-hosted documents
for people and AI agents, with rich-text editing, real-time collaboration,
sharing, version recovery, API access, and a CLI.

[Run locally](https://github.com/fullstack-ai-infra/doc/blob/main/docs/RUN_LOCAL.md) · [Capabilities](https://github.com/fullstack-ai-infra/doc/blob/main/docs/CAPABILITIES.md) · [Product direction](https://github.com/fullstack-ai-infra/doc/blob/main/GOAL.md)

These projects can be explored independently. Cross-project integration is
described as available only when the owning repositories provide release and
verification evidence.

## For builders

### [Design&nbsp;System](https://github.com/fullstack-ai-infra/design-system) — shared UI foundation

An experimental set of design tokens, accessible components, and application
patterns for a consistent ByteFolk experience. It is available for source
integration; no stable npm release is promised yet.

[Package guide](https://github.com/fullstack-ai-infra/design-system#develop-and-verify) · [Design decisions](https://github.com/fullstack-ai-infra/design-system/tree/main/docs/adr)

## How we work

- Start with a documented problem or outcome.
- Make changes through issues and pull requests, with passing checks and
  independent review.
- Validate claims with reproducible evidence.
- Prefer small, reviewable changes and transparent decisions.
- Keep shipped capabilities, experimental work, and future direction clearly
  separated.

## Get involved

- Start with the Digital Employee quickstart, or choose the product plane
  closest to your goal and read its status and setup documentation.
- Use the repository's issue templates for bugs, proposals, documentation,
  maintenance, and questions.
- Report vulnerabilities privately through the affected repository's
  **Security** tab.

Organization-wide policies:

- [Contributing](https://github.com/fullstack-ai-infra/.github/blob/main/CONTRIBUTING.md)
- [Governance](https://github.com/fullstack-ai-infra/.github/blob/main/GOVERNANCE.md)
- [Security](https://github.com/fullstack-ai-infra/.github/blob/main/SECURITY.md)
- [Support](https://github.com/fullstack-ai-infra/.github/blob/main/SUPPORT.md)
- [Code of Conduct](https://github.com/fullstack-ai-infra/.github/blob/main/CODE_OF_CONDUCT.md)

A repository's local policy supplies project-specific instructions while
preserving the organization baseline.
