class ApplicationController < ActionController::API
  def index
    render json: {
      version: Version::APP_VERSION,
      name: Version::APP_NAME,
    }
  end
end
