class CardsController < ApplicationController

  def new
  end

  def create
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # 環境変数を読み込む
    customer = Payjp::Customer.create(
      description: 'test', # テストカードであることを説明
      card: params[:token] # 登録しようとしているカード情報
    )
    card = Card.new(
      card_token: params[:token], #トークンを保存するカラム名:
      customer_token: customer.id, #顧客idを保存するカラム名:
      user_id: current_user.id 
    )
    if card.save!
    redirect_to root_path
    else
      redirect_to action: "new"
    end
  end
end
