class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items
  
  with_options presence: true do
  validates :nickname
  validates :password, format: {with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}/}
  validates :first_name
  validates :last_name
  validates :first_name_kana
  validates :last_name_kana
  validates :birthday
  end
  with_options format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/} do
  validates :first_name
  validates :last_name
  end
  with_options format: {with: /\A[ァ-ヶー－]+\z/} do
  validates :first_name_kana
  validates :last_name_kana
  end
end
