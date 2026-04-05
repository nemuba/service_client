# Data Model: ServiceClient::Response Status Feature

## Entities

### `ServiceClient::Response`

This class encapsulates the HTTP response from a service call. The feature introduces a new derived attribute to this existing entity.

#### Attributes:

- **`code` (Integer, existing)**: The HTTP status code (e.g., 200, 404, 500).
- **`data` (Hash, Array, or String, existing)**: The parsed body of the HTTP response.
- **`headers` (Hash, existing)**: The HTTP headers from the response.
- **`status` (String, NEW)**: A human-readable English string representation of the HTTP status code.
  - **Derivation**: Derived from the `code` attribute.
  - **Source for mapping**: `Rack::Utils::HTTP_STATUS_CODES`.
  - **Fallback**: If `code` is not found in the mapping, return a string indicating "Unknown Status [CODE]".