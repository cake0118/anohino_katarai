class ApplicationController < ActionController::Base

  def after_sign_up_path_for(resource)
    user_path(resource)
  end

  def after_sign_out_path_for(resource)
    case resource
    when Admin
      new_admin_session
    when User
      root_path
    else
      root_path
    end
  end
end

