class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
  end


  def show
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    card = Card.find_by(user_id: current_user.id)

    redirect_to new_card_path and return unless card.present?

    customer = Payjp::Customer.retrieve(card.customer_token) #先程のカード情報をもとに、顧客情報を取得
    @card = customer.cards.first #最初（first）のカード情報を取得する
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      redirect_to action: "show"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :first_name, :last_name, :first_name_kana, :last_name_kana, :birthday)
  end
end
