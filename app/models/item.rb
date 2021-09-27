class Item < ApplicationRecord
  belongs_to :user
  has_many_attached :images, dependent: :destroy
  has_one :purchase
  has_many :item_tag_relations, dependent: :destroy
  has_many :tags, through: :item_tag_relations, dependent: :destroy
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :item_status
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :delivery_day

  with_options presence: true do
    validates :title
    validates :images
    validates :description
  end

  validates :price, presence: true, format: { with: /\A[0-9]+\z/, message: 'を半角で入力してください' }
  validates :price,
            numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'は設定範囲外の値です' }

  with_options presence: true, numericality: { other_than: 1, message: 'を選択してください' } do
    validates :category_id
    validates :item_status_id
    validates :delivery_fee_id
    validates :prefecture_id
    validates :delivery_day_id
  end

  def tags_save(save_item_tags)
    save_item_tags.each do |new_name|
    item_tag = Tag.find_or_create_by(name: new_name)
    self.tags << item_tag
    end

    current_tags = self.tags.pluck(:name) unless self.tags.nil? #既存のタグを取得
    old_tags = current_tags - save_item_tags #消すタグを取得。引き算をしている
    new_tags = save_item_tags - current_tags #新たに追加するタグを取得

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name)
    end

    new_tags.each do |new_name|
      item_tag = Tag.find_or_create_by(name: new_name)
      self.tags << item_tag
    end
  end
end
