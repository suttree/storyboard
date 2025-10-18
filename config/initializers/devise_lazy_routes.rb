# config/initializers/devise_lazy_routes.rb
Rails.application.config.after_initialize do
  Devise.mappings # touch to ensure Devise loads its mappings
end

