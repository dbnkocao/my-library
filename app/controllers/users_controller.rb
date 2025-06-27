class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[new create]

  def create
    @user = User.new(user_params)

    if @user.save
      start_new_session_for @user
      redirect_to root_path, notice: "User created successfully."
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def new; end

  private

  def user_params
    params.require(:user).permit(:email_address, :password)
  end
end
