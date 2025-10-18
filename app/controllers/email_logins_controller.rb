class EmailLoginsController < ApplicationController
  # users aren’t signed in yet
  skip_before_action :authenticate_user!

  def new
  end

  def create
    # Paranoid flow: don’t disclose if email exists
    if (user = User.find_by(email: params[:email].to_s.downcase))
      if user.locked_at.present?
        flash.now[:alert] = "We’ve emailed instructions if your account is available."
        return render :new, status: :unprocessable_entity
      end

      code = user.generate_email_otp!
      OtpMailer.with(user:, code:).email_login_code.deliver_later
    end

    # Always say the same thing
    redirect_to verify_email_login_path(email: params[:email]),
                notice: "If that email exists, we sent a 6-digit code."
  end

  def verify
    @email = params[:email].to_s
  end

  def confirm
    email = params[:email].to_s.downcase
    code  = params[:code].to_s

    user = User.find_by(email:)
    unless user&.verify_email_otp!(code)
      # Optional: lock after too many tries (use Devise lockable too)
      flash.now[:alert] = "Invalid or expired code."
      @email = email
      return render :verify, status: :unauthorized
    end

    sign_in(user) # Devise helper
    redirect_to after_sign_in_path_for(user), notice: "Signed in."
  end
end

