class UsersController < ApplicationController
  before_action :load_user, only: [:show, :edit, :update]

  def index

  end

  def new

  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.add_role params[:role].to_sym
      redirect_to users_path
    else
      render :new
    end
  end

  def show

  end

  def edit

  end

  def update
    if @user.update(user_params)

      flash[:notice] = "Elemento guardado correctamente"
      redirect_to users_path
    else
      flash[:alert] = "Por favor, verifique su información"
      render :edit
    end
  end

  def _form

  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :mother_last_name)
  end

  def load_user
    @user = User.find(params[:id])
  end
end
