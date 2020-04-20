require_relative 'modules/validator'

class User
  include Validate

  validate :paw, absence: true

  def initialize(name, number, owner, paw)
    @name = name
    @number = number
    @owner = owner
    @paw = paw
    validate!
  end
end

user = User.new('sds', 11, Integer, 'Left Paw')
p user
