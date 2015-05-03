class BookPresenter
  attr_reader :book, :view

  def initialize(book, view)
    @book       = book
    @view = view
  end

  attr_accessor :current_user

  def index_haml(current_user)
    @current_user = current_user

    book_index_haml = <<HAML
%tr
  %td= book.title
  %td= book.author.name
  %td #{read_link}
#{index_action_links}
HAML
    Haml::Engine.new(book_index_haml).render(self)
  end

  def show_haml(current_user)
    @current_user = current_user

    book_show_haml = <<HAML
#{action_links.join(' ')}
HAML
    Haml::Engine.new(book_show_haml).render(self)
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
    reader_can_purchase = !!current_user
    links               = []

    if user_is_author
      links << edit_link
      links << delete_link

    elsif reader_can_purchase
      links << purchase_link
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
    view.link_to 'Purchase', '#'
  end
end
