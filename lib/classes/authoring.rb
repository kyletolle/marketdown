class Authoring
  extend Surrounded::Context

  initialize :author, :book

  role :book do
    def set_author
      self.user = author
    end
  end

  trigger :publish_book do
    book.set_author
    book.save
  end
end

