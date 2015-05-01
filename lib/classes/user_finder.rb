class UserFinder
  def initialize(user_name)
    @user_name = user_name
  end

  def find
    User.find_or_create_by(name: @user_name.downcase)
  end
end

