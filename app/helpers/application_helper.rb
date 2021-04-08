module ApplicationHelper
  def user_avatar(user)
    user.avatar_url.present? ? user.avatar_url : default_avatar(user)
  end

  def default_avatar(user)
    "https://via.placeholder.com/150.png/ddd/111?text=@#{user.username.capitalize}"
  end
end
