class SessionPresenter
  include ActionView::Helpers::UrlHelper

  def initialize(current_user)
    @current_user = current_user
  end

  def links
    @current_user ? 'users/sign_out_links' : 'users/sign_in_links'
  end
end

