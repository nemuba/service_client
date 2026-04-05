# Feature Specification: Add Request Status to ServiceClient::Response

**Feature Branch**: `001-response-status`  
**Created**: 2026-04-05  
**Status**: Draft  
**Input**: User description: "gostaria de adicionar o status da request no retorno da classe @lib/service_client/response.rb . me ajude a planejar adicionar o atributo status e retornar tbm"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Access Human-Readable Response Status (Priority: P1)

As a developer using `ServiceClient`, I want to easily access a human-readable string representing the HTTP status of a response, so that I can provide clearer feedback to users or logs without needing to interpret numerical HTTP codes.

**Why this priority**: Provides immediate value by making response handling more intuitive and improving developer experience, aligning with the "Clean API" principle.

**Independent Test**: Can be fully tested by making various HTTP requests (success, client error, server error) and asserting the returned `status` attribute on the `ServiceClient::Response` object.

**Acceptance Scenarios**:

1. **Given** a successful HTTP response (e.g., 200 OK), **When** I access `response.status`, **Then** it SHOULD return "OK".
2. **Given** a client error HTTP response (e.g., 404 Not Found), **When** I access `response.status`, **Then** it SHOULD return "Not Found".
3. **Given** a server error HTTP response (e.g., 500 Internal Server Error), **When** I access `response.status`, **Then** it SHOULD return "Internal Server Error".
4. **Given** any valid HTTP status code, **When** I access `response.status`, **Then** it SHOULD return the corresponding standard human-readable status phrase.

---

### Edge Cases

- What happens when a non-standard or unknown HTTP status code is received? The system should return a generic status like "Unknown Status" or the raw code itself.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The `ServiceClient::Response` class MUST expose a new public attribute named `status`.
- **FR-002**: The `status` attribute MUST return an English string representing the human-readable description of the HTTP status code.
- **FR-003**: The `status` attribute MUST accurately map standard HTTP status codes (1xx, 2xx, 3xx, 4xx, 5xx) to their corresponding standard phrases.
- **FR-004**: If an HTTP status code is not a known standard, the `status` attribute SHOULD return a fallback string indicating an unknown status, possibly including the numerical code itself.

### Key Entities *(include if feature involves data)*

- **ServiceClient::Response**: The existing class that encapsulates HTTP response data.
  - **Attributes**:
    - `code`: (existing) Integer representing the HTTP status code.
    - `data`: (existing) Parsed response body.
    - `headers`: (existing) Response headers.
    - `status`: (NEW) String representing the human-readable status phrase.

## Constraints

- **Scope Exclusion**: Complex localization/internationalization of status messages and custom status messages beyond standard HTTP status phrases are explicitly out of scope for this initial implementation.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: The `ServiceClient::Response` object consistently provides the correct human-readable `status` string for all standard HTTP codes (100-599).
- **SC-002**: Developers can retrieve the `status` attribute from `ServiceClient::Response` objects without additional parsing or external lookups.
- **SC-003**: For unknown or non-standard HTTP codes, the `status` attribute provides a graceful fallback (e.g., "Unknown Status 999").

## Assumptions

- The `status` attribute will derive its value from the `code` attribute already present in `ServiceClient::Response`.
- The mapping from numeric HTTP code to human-readable status string will rely on a robust, ideally built-in, mechanism (e.g., `Net::HTTP::STATUS_CODES` in Ruby's standard library or similar from HTTParty if available).
- The primary use case for this feature is improved logging and user feedback, with manual integration of the `status` attribute into developer-controlled logging being sufficient.

## Clarifications

### Session 2026-04-05

- Q: Are there any explicit features or use cases that are deliberately out of scope for this initial implementation of the `status` attribute? → A: Yes, both complex localization and custom status messages are out of scope.
- Q: For the human-readable status phrase, is English sufficient, or should localization be considered for different languages? → A: English is sufficient for the initial implementation.
- Q: Should the new `status` attribute be automatically included in `ServiceClient`'s internal logging where applicable, or is it sufficient for developers to manually integrate it into their logging? → A: Manual integration by developers is sufficient.
