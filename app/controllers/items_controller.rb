class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :user_confirmation, only: [:edit, :update, :destroy]
  # application_controllerではなく、items_controller記述する。
  # only: [:new]だけでなく、:createも記述することで、不正にアクセスした場合のセキュリティもカバーすることができる

  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new

  end

  def create
    @item = ItemsTag.new(item_params)
    tag_list = params[:item][:tagids].split(',')
    if @item.save
      @item.save_tags(tag_list)
      return redirect_to root_path
    else
      render :new
    end

  end

  def show
    @item = Item.find(params[:id])
    @tags = @item.tags
  end

  def edit
    @tag_list = @item.tags.pluck(:name).join(",")

    if @item.purchase != nil
      redirect_to root_path
    end
  end

  def update
    @tag_list = params[:item][:tag_ids].split(',')
    if @item.update_attributes(item_params) 
      @item.tags_save(@tag_list)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      redirect_to :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, {images:[]}, :category_id, :delivery_day_id, 
      :delivery_fee_id, :prefecture_id,:item_status_id, :price, :name).merge(user_id: current_user.id)                              
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def user_confirmation
    redirect_to root_path unless current_user.id == @item.user_id
  end


end