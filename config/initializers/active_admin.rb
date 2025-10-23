ActiveAdmin.setup do |config|
  config.site_title = "Admin"

  # Authentication settings
  config.authentication_method = :authenticate_admin_user!
  config.current_user_method = :current_admin_user
  config.logout_link_path = :destroy_admin_user_session_path

  # Deployment settings
  config.default_namespace = :admin
  config.root_to = 'questions#index'
end
