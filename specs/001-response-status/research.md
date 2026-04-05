# Research: HTTP Status Code to Human-Readable Phrase Mapping in Ruby

## Decision: Utilize `Rack::Utils::HTTP_STATUS_CODES` for mapping.

## Rationale:
The `Rack::Utils::HTTP_STATUS_CODES` hash provides a comprehensive and standard mapping of HTTP status codes to their human-readable phrases. Rack is a widely used interface between web servers and Ruby web frameworks, making its utility methods a reliable and common choice for such mappings in the Ruby ecosystem. It covers a broad range of standard codes and is readily available in most Rails/Rack environments.

## Alternatives considered:
- **`Net::HTTP::STATUS_CODES` (Ruby Standard Library)**: This is a viable option and also provides status code mappings. However, `Rack::Utils::HTTP_STATUS_CODES` is often more complete and consistently updated within a web application context. Given `ServiceClient` is likely to be used in web contexts, Rack's utility is a strong fit.
- **Manual Mapping**: Creating a custom hash mapping in `ServiceClient` itself was considered but rejected due to maintenance overhead and the risk of incompleteness or inconsistencies with official standards.
- **HTTParty's internal mechanisms**: While HTTParty provides the raw response code, it doesn't expose a direct utility for converting this code to a human-readable status phrase. Relying on an external, well-maintained utility is preferable.