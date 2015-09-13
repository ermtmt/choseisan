class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
  end

  def top
    if user_signed_in?
      redirect_to events_path
    else
      redirect_to root_path
    end
  end
end

