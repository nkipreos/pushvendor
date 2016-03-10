class Api::BaseController < ActionController::Base
  before_filter :authenticate

  private

  def authenticate
    token = "#{request.headers[API_KEY]}"
    unless ENV['API_KEY'] == token
      render_unauthorized
    end
  end

  def render_unauthorized
    key = request.headers[AUTH_HEADER_NAME]

    message = "Unauthorized access."
    if key.blank?
     message += " No API key"
    end

    render(json: {
      status: :error,
      response: {
        message: message
      }
    }, status: :unauthorized)
  end
end