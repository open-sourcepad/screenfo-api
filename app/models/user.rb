class User < ApplicationRecord

  include AuthenticableConcerns

  has_many :sessions
  has_many :messages

  validates :email, uniqueness: true

end
