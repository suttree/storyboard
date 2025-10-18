require 'securerandom'

class RegistrationsController < Devise::RegistrationsController
  # users aren’t signed in yet
  skip_before_action :authenticate_user!

  # Render email-only signup form
  def new
    super
  end

  # Create or find user by email and send OTP to login/signup
  def create
    email = sign_up_params[:email].to_s.downcase
    user = User.find_or_initialize_by(email: email)
    if user.new_record?
      random_pw = SecureRandom.hex(8)
      user.password = random_pw
      user.password_confirmation = random_pw
      user.save!
    end
    code = user.generate_email_otp!
    OtpMailer.with(user: user, code: code).email_login_code.deliver_later

    redirect_to verify_email_login_path(email: email),
                notice: "If that email exists, we sent a 6-digit code."
  end

  protected

  # Only allow email param for signup
  def sign_up_params
    params.require(resource_name).permit(:email)
  end
end
