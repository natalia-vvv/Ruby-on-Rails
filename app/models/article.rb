class Article < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { minimum: 3 }

  scope :ordered, -> { order(id: :desc) }
  scope :with_categories, -> { includes(:category) }
end
