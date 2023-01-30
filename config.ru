require_relative "./config/environment"

# Allow CORS (Cross-Origin Resource Sharing) requests
use Rack::Cors do
  allow do
    origins 'localhost:3000'
    #  '*'
      # allow requests from ALL frontend origins (if you deploy your application, change this to only allow requests from YOUR frontend origin like:
    # origins 'my-react-app.netlify.app')
    resource '*', headers: :any, methods: [:get, :post, :delete, :put, :patch, :options, :head]
  end
end

# Parse JSON from the request body into the params hash
use Rack::JSONBodyParser

# Our application
run ApplicationController
