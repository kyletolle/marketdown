class Authoring
  extend Surrounded::Context

  initialize :author, :book

  trigger :publish_book do
    book.author = author
    book.save
  end
end

