class MarkdownRendering
  extend Surrounded::Context

  initialize :book

  trigger :book_as_html do
    book.content.markdown_to_html
  end
end

