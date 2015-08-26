class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_filter :store_location

  def after_sign_in_path_for(resource)
    session[:previous_url] || events_path
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_in) << :username
      devise_parameter_sanitizer.for(:sign_up) << :name
      devise_parameter_sanitizer.for(:account_update) << :name
    end

    def store_location
      if (request.fullpath != "/users/sign_in" && \
          request.fullpath != "/users/sign_up" && \
          request.fullpath != "/users/sign_out" && \
          request.fullpath != "/users/edit" && \
          request.fullpath != "/" && \
          !request.xhr?)
        session[:previous_url] = request.fullpath 
        puts session[:previous_url]
      end
    end
end

