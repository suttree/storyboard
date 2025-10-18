class HomeController < ApplicationController
  # Public homepage
  skip_before_action :authenticate_user!, only: :index

  def index
  end
end
