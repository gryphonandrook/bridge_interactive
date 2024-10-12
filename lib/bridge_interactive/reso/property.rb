module BridgeInteractive
  module Reso
    class Property
      BASE_URL = 'https://api.bridgedataoutput.com/api/v2/OData/'

      def initialize(client, server_token)
        @client = client
        @server_token = server_token
      end

      # Fetch all properties from the specified dataset
      def all(dataset_id, filters = {})
        endpoint = "#{BASE_URL}#{dataset_id}/Properties"
        response = @client.get(endpoint, filters.merge(access_token: @server_token))
        handle_response(response)
      end

      # Fetch a specific property by their PropertyKey
      def find(dataset_id, property_id)
        endpoint = "#{BASE_URL}#{dataset_id}/Properties(#{property_id})"
        response = @client.get(endpoint, { access_token: @server_token })
        handle_response(response)
      end

      private

      # Handle API response and parse the JSON response
      def handle_response(response)
        if response.status == 200
          JSON.parse(response.body)
        else
          BridgeInteractive::Error.handle(response)
        end
      end
    end
  end
end
