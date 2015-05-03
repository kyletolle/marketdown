class Purchasing
  extend Surrounded::Context

  initialize :purchaser, :book

  role :book do
    def was_written_by_purchaser?
      self.author == purchaser
    end
  end

  role :purchaser do
    def owns_book?
      Purchase.where(purchaser: self, book: book).count > 0
    end
  end

  trigger :complete_purchase do
    return false unless purchaser
    return false if book.was_written_by_purchaser?
    return false if purchaser.owns_book?

    purchase = Purchase.new(purchaser: purchaser, book: book)
    purchase.save
  end

  trigger :purchaser_owns_book? do
    return purchaser.owns_book?
  end
end
