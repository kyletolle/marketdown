class Purchasing
  extend Surrounded::Context

  initialize :purchaser, :book

  role :book do
    def belongs_to_purchaser?
      self.author == purchaser
    end
  end

  role :purchaser do
    def has_already_purchased_book?
      Purchase.where(purchaser: self, book: book).count > 0
    end
  end

  trigger :complete_purchase do
    return false unless purchaser
    return false if book.belongs_to_purchaser?
    return false if purchaser.has_already_purchased_book?

    purchase = Purchase.new(purchaser: purchaser, book: book)
    purchase.save
  end
end
