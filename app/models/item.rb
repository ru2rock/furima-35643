class Item < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_one :purchase

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :item_status
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :delivery_day

  with_options presence: true do
    validates :images
    validates :title
    validates :description
  end

  validates :price, presence: true, format: { with: /\A[0-9]+\z/, message: 'Half-width number' }
  validates :price,
            numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'Out of setting range' }

  with_options presence: true, numericality: { other_than: 1, message: 'Select' } do
    validates :category_id
    validates :item_status_id
    validates :delivery_fee_id
    validates :prefecture_id
    validates :delivery_day_id
  end
end
