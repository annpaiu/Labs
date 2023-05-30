class ApplicationController < ActionController::Base
  before_action :check_user_session, unless: -> { devise_controller? }

  def check_user_session
    return if user_signed_in?

    return if request.original_fullpath == home_path

    redirect_to home_path,
                alert: 'You need to sign in or sign up before continuing!'
  end
end
