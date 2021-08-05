class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
  validates :nickname
  validates :password, :password_confirmation, format: {with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}/}
  validates :first_name
  validates :last_name
  validates :first_name_kana
  validates :last_name_kana
  validates :birthday
  end
  with_options format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/} do
  validates :first_name, {message: "First name is invalid. Input full-width characters"}
  validates :last_name, {message: "Last name is invalid. Input full-width characters"}
  end
  with_options format: {with: /\A[ァ-ヶー－]+\z/} do
  validates :first_name_kana, {message: "First name kana is invalid. Input full-width katakana characters"}
  validates :last_name_kana, {message: "Last name kana is invalid. Input full-width katakana characters"}
  end
end
