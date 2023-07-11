
require 'json'

module Middleware
  class StandardJsonResponse
    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, response = @app.call(env)
      body = JSON.parse(response.body)
      new_body = {"data": body}.to_json
      headers['Content-Length'] = new_body.bytesize.to_s
      [status, headers, [new_body]]
    end
  end
end
