# frozen_string_literal: true

# This module defines a set of error classes for common HTTP status codes. Each error class inherits from BaseError,
# which itself inherits from Ruby's StandardError class. These error classes are then used by the ServiceClient
# module to raise specific errors for specific HTTP status codes.

module ServiceClient
  # Errors module
  module Errors
    # BaseError class
    class BaseError < StandardError
      # Initializes a new instance of the BaseError class with the given message and HTTP response.
      # @param msg [String] The error message.
      # @param response [HTTParty::Response] The HTTP response that caused the error.
      def initialize(msg, response)
        @response = response
        super(msg)
      end

      # Returns the HTTP response that caused the error.
      # @return [HTTParty::Response] The HTTP response.
      attr_reader :response
    end

    # 400 – Bad Request
    class BadRequestError < BaseError; end
    # 401 – Unauthorized
    class UnauthorizedError < BaseError; end
    # 402 – Payment Required
    class PaymentRequiredError < BaseError; end
    # 403 – Forbidden
    class ForbiddenError < BaseError; end
    # 404 – Not Found
    class NotFoundError < BaseError; end
    # 405 – Method Not Allowed
    class MethodNotAllowedError < BaseError; end
    # 406 – Not Acceptable
    class NotAcceptableError < BaseError; end
    # 407 – Proxy Authentication Required
    class ProxyAuthenticationRequiredError < BaseError; end
    # 408 – Request Timeout
    class RequestTimeoutError < BaseError; end
    # 409 – Conflict
    class ConflictError < BaseError; end
    # 410 – Gone
    class GoneError < BaseError; end
    # 411 – Length Required
    class LengthRequiredError < BaseError; end
    # 412 – Precondition Failed
    class PreconditionFailedError < BaseError; end
    # 413 – Request Entity Too Large
    class RequestEntityTooLargeError < BaseError; end
    # 414 – Request-URI Too Long
    class RequestURITooLongError < BaseError; end
    # 415 – Unsupported Media Type
    class UnsupportedMediaTypeError < BaseError; end
    # 416 – Requested Range Not Satisfiable
    class RequestedRangeNotSatisfiableError < BaseError; end
    # 417 – Expectation Failed
    class ExpectationFailedError < BaseError; end
    # 420 – Enhance Your Calm
    class EnhanceYourCalmError < BaseError; end
    # 422 – Unprocessable Entity
    class UnprocessableEntityError < BaseError; end
    # 423 – Locked
    class LockedError < BaseError; end
    # 424 – Failed Dependency
    class FailedDependencyError < BaseError; end
    # 426 – Upgrade Required
    class UpgradeRequiredError < BaseError; end
    # 428 – Precondition Required
    class PreconditionRequiredError < BaseError; end
    # 429 – Too Many Requests
    class TooManyRequestsError < BaseError; end
    # 431 – Request Header Fields Too Large
    class RequestHeaderFieldsTooLargeError < BaseError; end
    # 444 – No Response
    class NoResponseError < BaseError; end
    # 449 – Retry With
    class RetryWithError < BaseError; end
    # 450 – Blocked by Windows Parental Controls
    class BlockedByWindowsParentalControlsError < BaseError; end
    # 451 – Unavailable For Legal Reasons
    class UnavailableForLegalReasonsError < BaseError; end
    # 499 – Client Closed Request
    class ClientClosedRequestError < BaseError; end
    # 500 – Internal Server Error
    class InternalServerError < BaseError; end
    # 501 – Not Implemented
    class NotImplementedError < BaseError; end
    # 502 – Bad Gateway
    class BadGatewayError < BaseError; end
    # 503 – Service Unavailable
    class ServiceUnavailableError < BaseError; end
    # 504 – Gateway Timeout
    class GatewayTimeoutError < BaseError; end
    # 505 – HTTP Version Not Supported
    class HTTPVersionNotSupportedError < BaseError; end
    # 506 – Variant Also Negotiates
    class VariantAlsoNegotiatesError < BaseError; end
    # 507 – Insufficient Storage
    class InsufficientStorageError < BaseError; end
    # 508 – Loop Detected
    class LoopDetectedError < BaseError; end
    # 510 – Not Extended
    class NotExtendedError < BaseError; end
    # 511 – Network Authentication Required
    class NetworkAuthenticationRequiredError < BaseError; end
    # 598 – Network Read Timeout Error
    class NetworkReadTimeoutError < BaseError; end
    # 599 – Network Connect Timeout Error
    class NetworkConnectTimeoutError < BaseError; end

    ERRORS = {
      '400': BadRequestError,
      '401': UnauthorizedError,
      '402': PaymentRequiredError,
      '403': ForbiddenError,
      '404': NotFoundError,
      '405': MethodNotAllowedError,
      '406': NotAcceptableError,
      '407': ProxyAuthenticationRequiredError,
      '408': RequestTimeoutError,
      '409': ConflictError,
      '410': GoneError,
      '411': LengthRequiredError,
      '412': PreconditionFailedError,
      '413': RequestEntityTooLargeError,
      '414': RequestURITooLongError,
      '415': UnsupportedMediaTypeError,
      '416': RequestedRangeNotSatisfiableError,
      '417': ExpectationFailedError,
      '420': EnhanceYourCalmError,
      '422': UnprocessableEntityError,
      '423': LockedError,
      '424': FailedDependencyError,
      '426': UpgradeRequiredError,
      '428': PreconditionRequiredError,
      '429': TooManyRequestsError,
      '431': RequestHeaderFieldsTooLargeError,
      '444': NoResponseError,
      '449': RetryWithError,
      '450': BlockedByWindowsParentalControlsError,
      '451': UnavailableForLegalReasonsError,
      '499': ClientClosedRequestError,
      '500': InternalServerError,
      '501': NotImplementedError,
      '502': BadGatewayError,
      '503': ServiceUnavailableError,
      '504': GatewayTimeoutError,
      '505': HTTPVersionNotSupportedError,
      '506': VariantAlsoNegotiatesError,
      '507': InsufficientStorageError,
      '508': LoopDetectedError,
      '510': NotExtendedError,
      '511': NetworkAuthenticationRequiredError,
      '598': NetworkReadTimeoutError,
      '599': NetworkConnectTimeoutError,
    }.freeze

    # Raises an error based on the given HTTP response.
    #
    # @param code [String] The HTTP response code.
    # @param response [HTTParty::Response] The HTTP response.
    # raise [BaseError] The error that corresponds to the given HTTP response code.
    # @return [void]
    def raise_error(code, response)
      raise ERRORS[code.to_sym].new(ERRORS[code.to_sym].class.name, response)
    end
  end
end
