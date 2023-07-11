require_relative "boot"

require "rails/all"
require_relative "../lib/middleware/standardJsonResponse"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CodespacesTryRails
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.api_only = true

    config.middleware.use Middleware::StandardJsonResponse
  end
end
