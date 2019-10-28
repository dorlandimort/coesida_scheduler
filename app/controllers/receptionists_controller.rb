class ReceptionistsController < ApplicationController
  before_action :set_receptionist, only: [:show, :edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html
      format.json do
        render json: ReceptionistDatatable.new(params, view_context: view_context)
      end
    end
  end

  def show; end

  def new
    @receptionist = Receptionist.new
  end

  def edit; end

  def create
    user = User.find(params[:receptionist][:user_id])
    @receptionist = Receptionist.new(receptionist_params)

    respond_to do |format|
      if @receptionist.save && user.update(user_params)
        format.html do
          flash[:notice] = 'El elemento ha sido guardado correctamente.'
          redirect_to receptionists_path
        end
        format.json { render :show, status: :created, location: @receptionist }
      else
        format.html do
          flash[:alert] = 'Ocurrió un error al guardar el elemento. Por favor verifique la información'
          render :new
        end
        format.json { render json: @receptionist.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    user = User.find(params[:receptionist][:user_id])
    respond_to do |format|
      if @receptionist.update(receptionist_params) && user.update(user_params)
        format.html do
          flash[:notice] = 'El elemento ha sido guardado correctamente.'
          redirect_to receptionists_path
        end
        format.json { render :show, status: :ok, location: @receptionist }
      else
        format.html do
          flash[:alert] = 'Ocurrió un error al guardar el elemento. Por favor verifique la información'
          render :edit
        end
        format.json { render json: @receptionist.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @receptionist.destroy
    respond_to do |format|
      format.html do
        flash[:notice] = 'El elemento ha sido eliminado correctamente'
        redirect_to receptionists_url
      end
      format.json { head :no_content }
    end
  end

  def _form; end

  private

  def set_receptionist
    @receptionist = Receptionist.find(params[:id])
  end

  def receptionist_params
    params.require(:receptionist).permit(:user_id, :work_center_id)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :mother_last_name)
  end
end
