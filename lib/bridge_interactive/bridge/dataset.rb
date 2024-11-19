module BridgeInteractive
  module Bridge
    class Dataset
      BASE_URL = 'https://api.bridgedataoutput.com/api/v2/'

      def initialize(client, server_token)
        @client = client
        @server_token = server_token
      end

      # Fetch all datasets approved for the application
      def all(filters = {})
        endpoint = "#{BASE_URL}datasets"
        response = @client.get(endpoint, filters.merge(access_token: @server_token))
        handle_response(response)
      end

      private

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
