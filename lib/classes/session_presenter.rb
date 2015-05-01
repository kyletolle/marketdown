class SessionPresenter
  include ActionView::Helpers::UrlHelper

  def initialize(current_user)
    @current_user = current_user
  end

  def links
    @current_user ? 'sign_out_links' : 'sign_in_links'
  end
end

