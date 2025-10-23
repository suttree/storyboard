class AdminUser < ApplicationRecord
  # ActiveAdmin default Devise modules
  devise :database_authenticatable, :recoverable, :rememberable, :validatable
end
