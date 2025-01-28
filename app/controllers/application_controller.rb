class ApplicationController < ActionController::Base
  # Devise コントローラーでのみ、許可パラメータの設定を実行
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Devise にカスタムパラメータ（name）を許可する設定
  def configure_permitted_parameters
    # 新規登録時に name を許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # ログイン時に name を許可
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
    # アカウント更新時に name を許可
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  # サインアップ後のリダイレクト先を質問一覧ページに設定
  def after_sign_up_path_for(resource)
    questions_path
  end

  # サインイン後のリダイレクト先を質問一覧ページに設定
  def after_sign_in_path_for(resource)
    questions_path
  end
end