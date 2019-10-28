class ManagersController < ApplicationController
  before_action :set_manager, only: [:show, :edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html
      format.json do
        render json: ManagerDatatable.new(params, view_context: view_context)
      end
    end
  end

  def show
  end

  def new
    @manager = Manager.new
  end

  def edit
  end

  def create
    user = User.find(params[:manager][:user_id])
    @manager = Manager.new(manager_params)
    respond_to do |format|
      if @manager.save && user.update(user_params)
        format.html do
          flash[:notice] = "El elemento fue guardado correctamente"
          redirect_to managers_path
        end
        format.json { render :show, status: :created, location: @manager }
      else
        format.html do
          flash[:alert] = "Ocurrió un error al guardar el elemento. Por favor revise la información."
          render :new
        end
        format.json { render json: @manager.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    user = User.find(params[:manager][:user_id])
    respond_to do |format|
      if @manager.update(manager_params) && user.update(user_params)
        format.html do
          flash[:notice] = "El elemento fue guardado correctamente"
          redirect_to managers_path
        end
        format.json { render :show, status: :ok, location: @manager }
      else
        format.html do
          flash[:alert] = "Ocurrió un error al guardar el elemento. Por favor revise la información."
          render :edit
        end
        format.json { render json: @manager.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @manager.destroy
    respond_to do |format|
      format.html do
        flash[:notice] = "El elemento fue eliminado correctamente"
        redirect_to managers_url
      end
      format.json { head :no_content }
    end
  end

  def _form; end

  private

  def set_manager
    @manager = Manager.find(params[:id])
  end

  def manager_params
    params.require(:manager).permit(:user_id, :work_center_id, :status)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :mother_last_name)
  end
end
