class RegistrationsController < Devise::RegistrationsController
  def create
    raise 'Password don\'t match' unless params[:password] == params[:password_confirmation]
    raise 'Phone number is not invalid' if params[:phone_number].present? && (params[:phone_number].size < 10)
    raise 'Email is invalid' unless (URI::MailTo::EMAIL_REGEXP).match? params[:email]

    user = User.new(
      name: params[:name],
      phone_number: (params[:phone_number] if params[:phone_number].present?),
      email: params[:email],
      password: params[:password],
      is_phone_verified: false
    )
    user.save!
    render json: { success: true, message: 'Account created' }, status: :ok
  rescue StandardError => e
    render json: { success: false, message: e.message }, status: :precondition_failed
  end
end
