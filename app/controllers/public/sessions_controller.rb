class Public::SessionsController < Devise::SessionsController

  def after_sign_in_path_for(resource)
    top_path
  end
end
