class PurchaseAddress
  include ActiveModel::Model #通常のモデルのようにvalidationを使えるようにする
  attr_accessor :item_id, :user_id, :postal_code, :prefecture_id, :town, :plot_number, :building, :phone_number, :token
  #フォームで保存したい各テーブルのカラム名全てを記述
  # ActiveHashの記述は要らない

  validates :prefecture_id, presence: true, numericality: {other_than: 1, message:"を入力してください"}
  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "は不正な値です。ハイフンを含めてください"}
    validates :town
    validates :plot_number
    validates :phone_number, numericality: { only_integer:true, message: "は数字のみで入力してください" }, format: {with: /\A[0-9]{11}\z/, message: 'は9桁から１２桁の半角で入力してください' }
  end

  def save
    @purchase = Purchase.create!(item_id: item_id, user_id: user_id)
    Address.create!(postal_code: postal_code, prefecture_id: prefecture_id, town: town, plot_number: plot_number, 
                   building: building, phone_number: phone_number, purchase_id: @purchase.id) 
  end
end
# Purchase.createやAddress.createの後に"!"をつけることによって、エラー文を表示させることができるようになり、
# テーブルに保存されていないのは何故か知ることができる。
# Address.saveやPurchase.saveなどの記述は"def save"では使えない。