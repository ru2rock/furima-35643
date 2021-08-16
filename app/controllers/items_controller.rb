class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  # application_controllerではなく、items_controllerni記述する。
  # only: [:new]だけでなく、:createも記述することで、不正にアクセスした場合のセキュリティもカバーすることができる

  def index
    @items = Item.all
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :image, :category_id, :delivery_days_id, :delivery_fee_id, :prefecture_id,
                                 :item_status_id, :price).merge(user_id: current_user.id)
  end
end
