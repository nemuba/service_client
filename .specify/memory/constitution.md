<!--
SYNC IMPACT REPORT
==================
Version change: (none) → 1.0.0
Bump rationale: Initial constitution creation from template. All placeholder tokens replaced with concrete values derived from project context.

Modified principles (template → concrete):
- [PRINCIPLE_1_NAME] → I. Library-First Design
- [PRINCIPLE_2_NAME] → II. Clean API & Comprehensive Error Handling
- [PRINCIPLE_3_NAME] → III. Test-First (NON-NEGOTIABLE)
- [PRINCIPLE_4_NAME] → IV. Documentation-Driven
- [PRINCIPLE_5_NAME] → V. Simplicity & YAGNI

Added sections:
- Additional Constraints (Ruby version, dependencies, code style, security)
- Development Workflow (testing, versioning, code review, release process)

Removed sections:
- None (all template slots filled)

Templates requiring updates:
- .specify/templates/plan-template.md: ✅ Compatible (Constitution Check section uses generic placeholder)
- .specify/templates/spec-template.md: ✅ Compatible (no constitution-specific references)
- .specify/templates/tasks-template.md: ✅ Compatible (task structure aligns with test-first principle)
- .specify/templates/commands/*.md: ⚠ N/A (no command files exist)

Follow-up TODOs:
- None

Deferred placeholders:
- None (all tokens resolved)
-->

# ServiceClient Constitution

## Core Principles

### I. Library-First Design

Every feature starts as library code; the gem MUST be self-contained, independently testable, and documented. No internal-only or organizational-only modules without clear public purpose. All public APIs must have a well-defined contract.

### II. Clean API & Comprehensive Error Handling

The public interface MUST remain intuitive and consistent. Every HTTP status code MUST have a corresponding error class. Error messages must be actionable. No silent failures — all errors propagate with context (status code, headers, response body).

### III. Test-First (NON-NEGOTIABLE)

TDD is mandatory: tests written → tests fail → then implement. Red-Green-Refactor cycle strictly enforced. All public methods MUST have test coverage. Use RSpec exclusively. No code merges without passing tests.

### IV. Documentation-Driven

All public methods, classes, and modules MUST have YARD documentation. Examples required for non-trivial usage. Documentation lives alongside code — no external-only docs for public APIs. README must reflect current usage patterns.

### V. Simplicity & YAGNI

Start with the simplest solution that works. No abstractions without demonstrated need. No anticipatory design. Every dependency must justify its weight. Prefer composition over inheritance. Methods with more than 10-15 lines require refactoring justification.

## Additional Constraints

**Ruby Version**: Minimum Ruby 2.7.1 compatibility required. All code must run on supported versions without version-specific features unless guarded.

**Dependencies**: Minimize external dependencies. Current core dependency is HTTParty. Any new dependency requires justification for size, maintenance status, and license compatibility (MIT preferred).

**Code Style**: Follow Ruby Style Guide. Use `frozen_string_literal` pragma in all files. Methods with more than 3 parameters must use keyword arguments. No metaprogramming without documented justification.

**Security**: Never log sensitive data (tokens, credentials, PII). All user input must be validated before use. No hardcoded secrets. Use bind parameters for any query construction.

## Development Workflow

**Testing**: Run `rake spec` before any commit. All tests must pass. New features require new tests. Bug fixes require regression tests.

**Versioning**: Follow semantic versioning (MAJOR.MINOR.PATCH). Version defined in `lib/service_client/version.rb`. Release via `bundle exec rake release` which creates git tag and pushes to rubygems.org.

**Code Review**: All changes require review before merge. Reviewers must verify: test coverage, documentation completeness, API consistency, and adherence to this constitution.

**Release Process**: Update version number → run full test suite → update CHANGELOG → `bundle exec rake release`. No direct pushes to main without PR.

## Governance

This constitution supersedes all other development practices. Amendments require documented rationale, approval from maintainers, and migration plan if breaking existing patterns.

All PRs and reviews MUST verify compliance with these principles. Complexity additions must be justified against YAGNI and Simplicity principles.

For runtime development guidance, refer to `README.md` and inline YARD documentation.

**Version**: 1.0.0 | **Ratified**: 2026-04-05 | **Last Amended**: 2026-04-05
