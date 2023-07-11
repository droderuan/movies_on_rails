
require 'json'

module Middleware
  class StandardJsonResponse
    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, response = @app.call(env)
      begin
        if response.respond_to? :body
          body = JSON.parse(response.body)
          if checkForPagination body
            new_body =  normalizeToPagination body
          else
            new_body = {"data": body}.to_json
          end

          headers['Content-Length'] = new_body.bytesize.to_s
          [status, headers, [new_body]]
        else
          [status, headers, response]
        end
      rescue
        [status, headers, response]
      end
    end

    private
      def checkForPagination(body)
        body.key? "paginated"
      end

      def normalizeToPagination(body)
        pagination_keys = ["next_page", "prev_page", "last_page", "per_page", "total_pages"]
        new_body = {}
        new_body["data"] = body.except("paginated", *pagination_keys)
        new_body[:page] = {}
        pagination_keys.each do |key|
          new_body[:page][key] = body[key]
        end


        new_body.to_json
      end

  end
end
