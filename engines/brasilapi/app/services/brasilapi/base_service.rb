require 'rest-client'

module Brasilapi
  class BaseService
    DOMAIN = 'https://brasilapi.com.br'

    attr_reader :param, :response

    def self.call(param:)
      new(param: param).call
    end

    def initialize(param:)
      @param = param
    end

    private

    def request_data
      @response = RestClient.get(url, { accept: :json })
    end

    def url
      raise NotImplementedError, 'You must implement the url method in the subclass'
    end
  end
end