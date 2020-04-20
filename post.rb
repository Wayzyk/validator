require_relative 'modules/validator'

class Post
  include Validate

  validate :owner, type: String

  def initialize(name, number, owner)
    @name = name
    @number = number
    @owner = owner
    validate!
  end
end

post = Post.new('sds', 11, Integer)
p post
