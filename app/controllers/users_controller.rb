class UsersController < ApplicationController
  def show
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      redirect_to action: "show"
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :first_name, :last_name, :first_name_kana, :last_name_kana, :birthday)
  end
end
