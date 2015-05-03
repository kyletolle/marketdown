class BookPresenter
  attr_reader :book, :view

  def initialize(book, view)
    @book       = book
    @view = view
  end

  attr_accessor :current_user

  def for_index(current_user)
    @current_user = current_user

    book_index_haml = <<HAML
%tr
  %td #{book.title}
  %td #{book.author.name}
  %td #{read_link}
#{index_action_links}
HAML
    Haml::Engine.new(book_index_haml).render
  end

  def links_for_show(current_user)
    @current_user = current_user

    book_show_haml = <<HAML
#{action_links.join(' ')}
HAML
    Haml::Engine.new(book_show_haml).render
  end

private
  def read_link
    view.link_to 'Read', book
  end

  def index_action_links
    action_links do |link|
<<HAML
  %td #{link}
HAML
    end.join('')
  end

  def action_links(&block)
    user_is_author      = current_user == book.author
    reader_is_signed_in = !!current_user
    links               = []

    if user_is_author
      links << edit_link
      links << delete_link

    elsif reader_is_signed_in
      user_has_purchased_book = Purchasing.new(current_user, book).purchaser_owns_book?
      if user_has_purchased_book
        links << %{You own this book!}

      else
        links << purchase_link
      end

    else
      links << sign_in_to_purchase_link
    end

    if block_given?
      links.map!{|link| yield link}
    end

    links
  end

  def edit_link
    view.link_to 'Edit', view.edit_book_path(book)
  end

  def delete_link
    view.link_to 'Delete', book, method: :delete, data: { confirm: 'Are you sure?' }
  end

  def purchase_link
    view.link_to 'Purchase', view.purchase_book_path(book), method: :post, data: { confirm: 'Are you sure you want to purchase this book?' }
  end

  def sign_in_to_purchase_link
    view.link_to "Sign in to Purchase", :root
  end
end
