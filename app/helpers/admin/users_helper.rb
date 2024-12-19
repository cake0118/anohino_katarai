module Admin::UsersHelper

  def user_status(user)
    user.is_active ? '有効' : '退会'
  end
end
