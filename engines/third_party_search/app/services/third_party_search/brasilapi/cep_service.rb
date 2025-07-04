module ThirdPartySearch
  module Brasilapi
    class CepService < BaseService
      def call
        request_data

        result.new(success: true, data: JSON.parse(response.body))
      rescue RestClient::BadRequest, RestClient::GatewayTimeout, RestClient::NotFound
        result.new(success: false, error: "Endereço com o cep #{param} não foi encontrado.")
      end

      private

      def url
        "#{DOMAIN}/api/cep/v1/#{param}"
      end
    end
  end
end