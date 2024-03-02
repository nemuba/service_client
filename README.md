*# ServiceClient

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/service_client`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'service_client'
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install service_client
```

## Usage

Basic usage example:

```ruby
class CustomerClient < ServiceClient::Base
  base_url 'https://api.com'
  default_headers content_type: 'application/json'

  def find(id)
    response = get("customers/#{id}")

    response.data
  rescue ServiceClient::Errors::NoDataFoundError => e
    puts e.response.code # 404
    puts e.response.headers
    puts e.response.data 
  rescue ServiceClient::Errors::InternalServerError => e
    puts e.response.code # 500
    puts e.response.headers
    puts e.response.data
  # All errors of HTTP status code
  end

  def all
    get(nil)
  rescue ServiceClient::ParamsRequired => e
    puts e.message
  end
end
```

## Methods of class

```ruby
# GET
ServiceClient::Base.get(url, headers:)

# POST
ServiceClient::Base.post(url, headers:, body:)

# PUT
ServiceClient::Base.put(url, headers:, body:)

# DELETE
ServiceClient::Base.delete(url, headers:, body:)
```

## Classes of errors

```ruby
  # 400 – Bad Request
  ServiceClient::Errors::BadRequestError
  # 401 – Unauthorized
  ServiceClient::Errors::UnauthorizedError
  # 402 – Payment Required
  ServiceClient::Errors::PaymentRequiredError
  # 403 – Forbidden
  ServiceClient::Errors::ForbiddenError
  # 404 – Not Found
  ServiceClient::Errors::NotFoundError
  # 405 – Method Not Allowed
  ServiceClient::Errors::MethodNotAllowedError
  # 406 – Not Acceptable
  ServiceClient::Errors::NotAcceptableError
  # 407 – Proxy Authentication Required
  ServiceClient::Errors::ProxyAuthenticationRequiredError
  # 408 – Request Timeout
  ServiceClient::Errors::RequestTimeoutError
  # 409 – Conflict
  ServiceClient::Errors::ConflictError
  # 410 – Gone
  ServiceClient::Errors::GoneError
  # 411 – Length Required
  ServiceClient::Errors::LengthRequiredError
  # 412 – Precondition Failed
  ServiceClient::Errors::PreconditionFailedError
  # 413 – Request Entity Too Large
  ServiceClient::Errors::RequestEntityTooLargeError
  # 414 – Request-URI Too Long
  ServiceClient::Errors::RequestURITooLongError
  # 415 – Unsupported Media Type
  ServiceClient::Errors::UnsupportedMediaTypeError
  # 416 – Requested Range Not Satisfiable
  ServiceClient::Errors::RequestedRangeNotSatisfiableError
  # 417 – Expectation Failed
  ServiceClient::Errors::ExpectationFailedError
  # 420 – Enhance Your Calm
  ServiceClient::Errors::EnhanceYourCalmError
  # 422 – Unprocessable Entity
  ServiceClient::Errors::UnprocessableEntityError
  # 423 – Locked
  ServiceClient::Errors::LockedError
  # 424 – Failed Dependency
  ServiceClient::Errors::FailedDependencyError
  # 426 – Upgrade Required
  ServiceClient::Errors::UpgradeRequiredError
  # 428 – Precondition Required
  ServiceClient::Errors::PreconditionRequiredError
  # 429 – Too Many Requests
  ServiceClient::Errors::TooManyRequestsError
  # 431 – Request Header Fields Too Large
  ServiceClient::Errors::RequestHeaderFieldsTooLargeError
  # 444 – No Response
  ServiceClient::Errors::NoResponseError
  # 449 – Retry With
  ServiceClient::Errors::RetryWithError
  # 450 – Bllocked by Windows Parental Controls
  ServiceClient::Errors::BlockedByWindowsParentalControlsError
  # 451 – Unavailable For Legal Reasons
  ServiceClient::Errors::UnavailableForLegalReasonsError
  # 499 – Client Closed Request
  ServiceClient::Errors::ClientClosedRequestError
  # 500 – Internal Server Error
  ServiceClient::Errors::InternalServerError
  # 501 – Not Implemented
  ServiceClient::Errors::NotImplementedError
  # 502 – Bad Gateway
  ServiceClient::Errors::BadGatewayError
  # 503 – Service Unavailable
  ServiceClient::Errors::ServiceUnavailableError
  # 504 – Gateway Timeout
  ServiceClient::Errors::GatewayTimeoutError
  # 505 – HTTP Version Not Supported
  ServiceClient::Errors::HTTPVersionNotSupportedError
  # 506 – Variant Also Negotiates
  ServiceClient::Errors::VariantAlsoNegotiatesError
  # 507 – Insufficient Storage
  ServiceClient::Errors::InsufficientStorageError
  # 508 – Loop Detected
  ServiceClient::Errors::LoopDetectedError
  # 510 – Not Extended
  ServiceClient::Errors::NotExtendedError
  # 511 – Network Authentication Required
  ServiceClient::Errors::NetworkAuthenticationRequiredError
  # 598 – Network Read Timeout Error
  ServiceClient::Errors::NetworkReadTimeoutError
  # 599 – Network Connect Timeout Error
  ServiceClient::Errors::NetworkConnectTimeoutError
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/nemuba/service_client>.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
