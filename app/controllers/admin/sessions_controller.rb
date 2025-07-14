class Admin::SessionsController < Devise::SessionsController

  # ログイン後の遷移先の設定
  def after_sign_in_path_for(resource)
    root_path
  end
end
