class Article < ApplicationRecord
  belongs_to :user
  belongs_to :categorie
  has_one_attached :image
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :image, attached: true
  validates :content, presence: true
end
