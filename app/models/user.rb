class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
  validates :nickname
  validates :encrypted_password,:password,:password_confirmation, format: {with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}/}
  validates :first_name, format: {with: /\A[ぁ-んァ-ン一-龥]/, message: "First name is invalid. Input full-width characters"}
  validates :last_name, format: {with: /\A[ぁ-んァ-ン一-龥]/, message: "Last name is invalid. Input full-width characters"}
  validates :first_name_kana, format: {with: /\A[ァ-ヶー－]+\z/, message: "First name kana is invalid. Input full-width katakana characters"}
  validates :last_name_kana, format: {with: /\A[ァ-ヶー－]+\z/, message: "Last name kana is invalid. Input full-width katakana characters"}
  validates :birthday
  end
end
