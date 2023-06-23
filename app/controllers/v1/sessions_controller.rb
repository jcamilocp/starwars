class V1::SessionsController < Devise::SessionsController
  before_action :login_params, only: :create
  before_action :find_user, only: :create

  def create
    if @user.valid_password?(login_params[:password])
      sign_in 'user', @user
      render json: { messages: 'Logged in Successfully', data: { user: @user } }, status: :ok
    else
      render json: { messages: 'Login Failed - Wrong Password', data: {} }, status: :unauthorized
    end
  end

  private

  def login_params
    params.require(:login).permit(:email, :password)
  end

  def find_user
    @user = User.find_for_database_authentication(email: login_params[:email])
    return  @user if @user.present?

    render json: { messages: 'User not found', data: {} }, status: :bad_request
  end
end
