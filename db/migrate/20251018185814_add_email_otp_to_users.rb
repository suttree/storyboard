class AddEmailOtpToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :email_otp_digest, :string
    add_column :users, :email_otp_sent_at, :datetime
    add_column :users, :email_otp_attempts, :integer
  end
end
