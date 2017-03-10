class User < ApplicationRecord
  include AuthenticableConcerns
  has_many :sessions
end
