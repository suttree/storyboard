# app/models/user.rb
class User < ApplicationRecord
  devise :registerable, :confirmable, :trackable, :validatable, :lockable,
         :timeoutable, :rememberable, :database_authenticatable # keep if you also allow password logins

  OTP_TTL       = 10.minutes
  OTP_LENGTH    = 6
  MAX_OTP_TRIES = 5

  def generate_email_otp!
    code = format("%0#{OTP_LENGTH}d", SecureRandom.random_number(10**OTP_LENGTH))
    digest = BCrypt::Password.create(code)

    update!(
      email_otp_digest:   digest,
      email_otp_sent_at:  Time.current,
      email_otp_attempts: 0
    )

    # Return code so caller (controller) can mail it
    code
  end

  def email_otp_expired?
    email_otp_sent_at.blank? || email_otp_sent_at < OTP_TTL.ago
  end

  def verify_email_otp!(submitted_code)
    return false if email_otp_expired? || email_otp_attempts.to_i >= MAX_OTP_TRIES
    return false if email_otp_digest.blank? || submitted_code.to_s.strip.empty?

    ok = BCrypt::Password.new(email_otp_digest) == submitted_code.to_s
    increment!(:email_otp_attempts) unless ok

    if ok
      # burn the OTP
      update!(email_otp_digest: nil, email_otp_sent_at: nil, email_otp_attempts: 0)
      true
    else
      false
    end
  end
end

