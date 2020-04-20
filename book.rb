require_relative 'modules/validator'

class Book
  include Validate

  validate :name, absence: true
  # validate :number, format: /A-Z{0,3}/
  # validate :owner, type: String

  def initialize(name, number, owner)
    @name = name
    @number = number
    @owner = owner
    validate!
  end
end

book = Book.new('sds', 11, Integer)
p book
