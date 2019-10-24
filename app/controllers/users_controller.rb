class UsersController < ApplicationController
  before_action :load_user, only: %i[show edit update]

  def index
    respond_to do |format|
      format.html
      format.json do
        render json: UserDatatable.new(params, view_context: view_context)
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.add_role params[:role].to_sym
      flash[:notice] = "El usuario ha sido guardado correctamente"
      redirect_to users_path
    else
      flash[:alert] = "Ocurrió un error al guardar al usuario, verifique la información"
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    password = params[:user][:password]
    saved = password.blank? ? @user.update_without_password(user_params) : @user.update(user_params)

    if saved
      flash[:notice] = "Elemento guardado correctamente"
      redirect_to users_path
    else
      flash[:alert] = "Por favor, verifique su información"
      render :edit
    end
  end

  def _form; end

  def check_existence
    if params[:id].blank?
      existence = (User.where(email: params[:email]).any? ? 'Esta dirección de email ya está ocupada en el sistema': 'true')
    else
      existence = (User.where(email: params[:email]).where.not(id: params[:id]).any? ? 'Esta dirección de email ya está ocupada en el sistema': 'true')
    end
    render json: existence.to_json
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :first_name, :last_name, :mother_last_name)
  end

  def load_user
    @user = User.find(params[:id])
  end
end
