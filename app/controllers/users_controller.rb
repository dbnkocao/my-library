class UsersController < ApplicationController
  include Authentication
  allow_unauthenticated_access only: %i[new create]

  def create
    @user = User.new(user_params)

    if @user.save
      @user.create_library
      start_new_session_for @user
      redirect_to root_path, notice: "User created successfully."
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def new; end

  def edit
    @user = current_user
    @user.address = Address.new if @user.address.nil?

    search_address if params[:zipcode].present?
  end

  def update
    @user = current_user

    if @user.update(update_params)
      redirect_to root_path
    else
      flash[:error] = "Error in updating data"
      render :edit
    end
  end

  private

  def search_address
    result = ThirdPartySearch::Brasilapi::CepService.call(param: params[:zipcode])

    if result.success
      @user.address.zipcode = params[:zipcode]
      @user.address.assign_attributes(result.data.except("cep", "service"))
    else
      flash.now[:error] = result[:error]
    end
  end

  def user_params
    params.require(:user).permit(:email_address, :password)
  end

  def update_params
    params.require(:user).permit(address_attributes: %i[address zipcode state city neighborhood street])
  end
end
