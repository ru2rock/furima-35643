class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :limitted_access, only: [:index, :create]

  def index
    @purchase_address = PurchaseAddress.new 
    @card = Card.new
  end

  def create
    redirect to new_card_path and return unless current_user.card.present?

    @purchase_address = PurchaseAddress.new(purchase_params)

    @purchase_address.valid? 
    pay_item
    Purchase.create(item_id: params[:id])
    @purchase_address.save
    redirect_to root_path
        
  end

  private

  def purchase_params
    params.require(:purchase_address).permit(:postal_code, :prefecture_id, :town, :plot_number, :building, :phone_number)
    .merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def limitted_access
    if @item.user_id == current_user.id || @item.purchase != nil
      redirect_to root_path
    end
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    customer_token = current_user.card.customer_token #顧客トークンを取得
    Payjp::Charge.create( #PAYJPに購入価格と顧客トークン、通貨の種類を渡す
      amount: @item.price,
      customer: customer_token,
      currency: 'jpy'
    )
  end
end
