require 'rest-client'
module ThirdPartySearch
  module Brasilapi
    class BaseService
      DOMAIN = 'https://brasilapi.com.br'

      attr_reader :param, :response, :result

      def self.call(param:)
        new(param: param).call
      end

      def initialize(param:)
        @param = param
        @result = Struct.new(:success, :data, :error)
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
end
