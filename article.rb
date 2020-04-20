require_relative 'modules/validator'

class Article
  include Validate

  validate :number, format: /A-Z{0,3}/

  def initialize(name, number, owner)
    @name = name
    @number = number
    @owner = owner
    validate!
  end
end

article = Article.new('sds', 11, Integer)
p article
