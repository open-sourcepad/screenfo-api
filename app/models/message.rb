class Message < ApplicationRecord

  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true

  scope :latest, -> { order(created_at: :desc) }

  def broadcasted!
    update_attribute(:broadcasted, true)
  end

end
