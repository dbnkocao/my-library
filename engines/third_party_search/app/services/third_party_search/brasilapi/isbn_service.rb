module ThirdPartySearch
  module Brasilapi
    class IsbnService < BaseService
      def call
        request_data

        result.new(success: true, data: JSON.parse(response.body))
      rescue RestClient::BadRequest
        result.new(success: false, error: "Book with isbn #{param} not found.")
      end

      private

      def url
        "#{DOMAIN}/api/isbn/v1/#{param}"
      end
    end
  end
end
