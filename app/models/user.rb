class User < ApplicationRecord

  include AuthenticableConcerns
  has_many :sessions

  validates :email, uniqueness: true

end
