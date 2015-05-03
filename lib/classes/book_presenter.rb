class BookPresenter

  attr_reader :book, :view

  def initialize(book, view)
    @book       = book
    @view = view
  end

  attr_accessor :current_user

  def index_haml(current_user)
    self.current_user = current_user

    book_index_haml = <<-EOB
%tr
  %td= book.title
  %td= book.author.name
  #{read_link}
  #{action_links}
    EOB
    Haml::Engine.new(book_index_haml).render(self)
  end

private
  def read_link
<<HAML
%td= view.link_to 'Read', book
HAML
  end

  def action_links
    user_is_author      = current_user == book.author
    reader_can_purchase = !!current_user
    if user_is_author
<<HAML
%td= view.link_to 'Edit', view.edit_book_path(book)
%td= view.link_to 'Delete', book, method: :delete, data: { confirm: 'Are you sure?' }
HAML
    elsif reader_can_purchase
<<HAML
%td= view.link_to 'Purchase', '#'
HAML
    else
<<HAML
%td &nbsp;
HAML
    end
  end
end
