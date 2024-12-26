# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :user_state, only: [:create]
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def guest_sign_in
    guest_user = User.find_or_create_by(email: 'guest@example.com') do |user|
      user.password = SecureRandom.hex(16)  # ゲスト用のパスワードをランダムに設定
      user.handle_name = "ゲストユーザー"
      user.is_active = true  # 必要に応じて、ゲストユーザーのアクティブ状態を設定
    end
    sign_in guest_user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  private

  # アクティブであるかを判断するメソッド
  def user_state
    # 【処理内容1】 入力されたemailからアカウントを1件取得
    user = User.find_by(email: params[:user][:email])

    # 【処理内容2】 アカウントを取得できなかった場合、このメソッドを終了する
    return if user.nil?

    # 【処理内容3】 パスワードが一致していない場合、このメソッドを終了する
    return unless user.valid_password?(params[:user][:password])

    # 【処理内容4】 アクティブでない会員に対する処理
    if !user.is_active
      redirect_to new_user_registration_path, alert: '退会済みのアカウントです。再登録を行ってください。'
    end
  end
end
