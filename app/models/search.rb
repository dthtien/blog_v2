class Search
  attr_reader :term
  def initialize(options = {})
    @term = options.fetch(:term, "") 
  end

  def articles
    Article.search(term)
  end
end