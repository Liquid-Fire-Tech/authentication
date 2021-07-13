module Authentication
  class ApiController < ActionController::Api
    protect_from_forgery with: :null_session
    include DeviseTokenAuth::Concerns::SetUserByToken
  end
end
