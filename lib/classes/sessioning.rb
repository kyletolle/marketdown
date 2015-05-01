require 'surrounded'

class Sessioning
  extend Surrounded::Context

  initialize :user, :session

  trigger :sign_in do
    session.remember_user
  end

  trigger :sign_out do
    session.forget_user
  end

  role :session do
    def remember_user
      session[:user_id] = user.id
    end

    def forget_user
      session.destroy
    end
  end
end

