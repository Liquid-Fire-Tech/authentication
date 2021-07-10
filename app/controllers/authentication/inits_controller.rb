require_dependency "authentication/application_controller"

module Authentication
  class InitsController < ApplicationController
    def index
      render json: { success: true }, status: :ok
    end
  end
end
