module BridgeInteractive
  class Error
    def self.handle(response)
      begin
        results = JSON.parse(response.body)
        if results.key?("bundle")
          message = "#{results['bundle']['name']}: #{results['bundle']['message']}"
        elsif results.key?("error")
          message = "Error #{results['error']['code']}: #{results['error']['message']}"
        else
          message = "Error not recognized: #{response.body}"
        end
      rescue => e
        message = "Error: #{e.message}"
      end
      raise StandardError, message
    end
  end
end
