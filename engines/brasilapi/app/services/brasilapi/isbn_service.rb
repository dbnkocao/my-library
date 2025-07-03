module Brasilapi
  class IsbnService < BaseService
    def call
      request_data

      result.new(success: true, data: JSON.parse(response.body))
    rescue RestClient::BadRequest
      result.new(success: false, error: "Livro com o isbn #{param} não foi encontrado.")
    end

    private

    def url
      "#{DOMAIN}/api/isbn/v1/#{param}"
    end
  end
end