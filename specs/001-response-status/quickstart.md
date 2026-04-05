# Quickstart: Accessing Response Status

This quickstart guide demonstrates how to access the new `status` attribute from a `ServiceClient::Response` object.

## Prerequisites

- `service_client` gem installed and configured in your Ruby project.

## Example Usage

Assuming you have a `ServiceClient::Base` subclass set up (e.g., `CustomerClient` as in the main `README.md`):

```ruby
require 'service_client'

class CustomerClient < ServiceClient::Base
  base_url 'https://api.example.com' # Replace with your actual base URL
  default_headers 'Content-Type': 'application/json'

  def get_customer(id)
    response = get("customers/#{id}")
    response # Returns ServiceClient::Response object
  rescue ServiceClient::Errors::ServiceClientError => e
    e.response # Returns ServiceClient::Response object even on error
  end
end

# --- Successful Response ---
begin
  client = CustomerClient.new
  success_response_object = client.get_customer(1) # Assuming this returns a 200 OK
  
  puts "Success Response Code: #{success_response_object.code}"
  puts "Success Response Status: #{success_response_object.status}" # Expected: "OK"
  puts "Success Response Data: #{success_response_object.data}"
rescue StandardError => e
  puts "An unexpected error occurred: #{e.message}"
end

puts "\n--- Error Response (e.g., 404 Not Found) ---"
begin
  client = CustomerClient.new
  not_found_response_object = client.get_customer(9999) # Assuming this returns a 404 Not Found

  # Even if an error is raised, you can catch ServiceClient::Errors::ServiceClientError
  # and access the response object to get details.
rescue ServiceClient::Errors::NotFoundError => e
  error_response_object = e.response
  puts "Error Response Code: #{error_response_object.code}" # Expected: 404
  puts "Error Response Status: #{error_response_object.status}" # Expected: "Not Found"
  puts "Error Response Data: #{error_response_object.data}"
  puts "Error Message: #{e.message}"
rescue StandardError => e
  puts "An unexpected error occurred: #{e.message}"
end
```

This example demonstrates how to make a request and then access the `code` and the newly added `status` attributes from the `ServiceClient::Response` object for both successful and error scenarios.