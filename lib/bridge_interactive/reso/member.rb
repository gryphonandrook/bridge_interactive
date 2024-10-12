module BridgeInteractive
  module Reso
    class Member
      BASE_URL = 'https://api.bridgedataoutput.com/api/v2/OData/'

      def initialize(client, server_token)
        @client = client
        @server_token = server_token
      end

      # Fetch all members from the specified dataset
      def all(dataset_id, filters = {})
        endpoint = "#{BASE_URL}#{dataset_id}/Member"
        response = @client.get(endpoint, filters.merge(access_token: @server_token))
        handle_response(response)
      end

      # Fetch a specific member by MemberKey
      def find(dataset_id, member_key)
        endpoint = "#{BASE_URL}#{dataset_id}/Member('#{member_key}')"
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
