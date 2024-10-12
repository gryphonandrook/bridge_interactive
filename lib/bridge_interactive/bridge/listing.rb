module BridgeInteractive
  module Bridge
    class Listing
      BASE_URL = 'https://api.bridgedataoutput.com/api/v2/'

      def initialize(client, server_token)
        @client = client
        @server_token = server_token
      end

      # Fetch all listings from the specified dataset
      def all(dataset_id, filters = {})
        endpoint = "#{BASE_URL}#{dataset_id}/listings"
        response = @client.get(endpoint, filters.merge(access_token: @server_token))
        handle_response(response)
      end

      # Fetch a specific listing by their listing ID
      def find(dataset_id, listing_id)
        endpoint = "#{BASE_URL}#{dataset_id}/listings/#{listing_id}"
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
