class OtpMailer < ApplicationMailer
  def email_login_code
    @user = params[:user]
    @code = params[:code]
    mail to: @user.email, subject: "Your sign-in code"
  end
end
