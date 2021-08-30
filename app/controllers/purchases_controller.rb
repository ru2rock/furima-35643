class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :move_to_index, only: [:index, :create]
  before_action :limitted_access, only: [:index, :create]

  def index
    @purchase_address = PurchaseAddress.new #index.html.erbのform_withで@purchase_addressモデルを使用しているため、ここにモデル名を定義することで、purchase_paramsのrequire(purchase_params)が使えるようになる。
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_params) 
    # @purchase =としていたところを、@purchase_addressとした。index.html.erbで保存した場合で、うまく保存できなかった場合に、
    # indexアクションにレンダリングされていたため、エラーが起きていた。保存時のエラー文表示をしたい場合には、createアクションに上記を記述する。
    if @purchase_address.valid? #valid?メソッドを使用しているのは、PurchaseAddressクラスがApplicationRecordを継承していないことにより、saveメソッドにはバリデーションを実行する機能がないため。
      pay_item
      @purchase_address.save
     return redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_address).permit(:postal_code, :prefecture_id, :town, :plot_number, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end
 #require(:モデル名)の記述がいるか、いらないかは、ビューファイルでform_withに@model名を記述しているか（必要）、いないか（不必要）、
 #または記述しているが受け取れていない場合は"param is missing or the value is empty: purchase_address"というようなエラーが出る。
 #以上の場合はparameterをみると、ハッシュが二重構造になっていないことで確認することができる。
 #.merge(カラム名：追加したいデータ値)

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_index
    redirect_to new_user_session_path unless user_signed_in?
  end

  def limitted_access
    if @item.user_id == current_user.id || @item.purchase != nil
      #ログイン中のユーザーと商品出品者が同一人物、又は、出品された商品の購入履歴があれば（購入履歴がないことが、なければ）
      redirect_to root_path
    end
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end
end
