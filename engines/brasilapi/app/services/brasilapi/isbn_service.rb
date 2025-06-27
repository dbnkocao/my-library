require 'rest-client'

module Brasilapi
  class IsbnService < BaseService
    attr_reader :isbn, :response

    def self.call(isbn:)
      new(isbn: isbn).call
    end

    def initialize(isbn:)
      @isbn = isbn
    end

    def call
      request_data

      { success: true, response: JSON.parse(response.body) } if @response.code == 200
    rescue RestClient::BadRequest
      { success: false, error: "Lirvro com o isbn #{isbn} não foi encontrado." }
    end

    private

    def request_data
      @response = RestClient.get(url, { accept: :json })
    end

    def url
      "#{DOMAIN}/api/isbn/v1/#{isbn}"
    end
  end
end