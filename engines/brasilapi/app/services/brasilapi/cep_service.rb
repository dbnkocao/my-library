module Brasilapi
  class CepService < BaseService
    def call
      request_data

      { success: true, response: JSON.parse(response.body) }
    rescue RestClient::BadRequest, RestClient::GatewayTimeout, RestClient::NotFound
      { success: false, error: "Endereço com o cep #{param} não foi encontrado." }
    end

    private

    def url
      "#{DOMAIN}/api/cep/v1/#{param}"
    end
  end
end
