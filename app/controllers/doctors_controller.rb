class DoctorsController < ApplicationController
  before_action :set_doctor, only: %i[show edit update destroy]

  def index
    respond_to do |format|
      format.html
      format.json do
        render json: DoctorDatatable.new(params, view_context: view_context)
      end
    end
  end

  def show; end

  def new
    @doctor = Doctor.new
  end

  def edit; end

  def create
    user = User.find(params[:doctor][:user_id])
    @doctor = Doctor.new(doctor_params)
    respond_to do |format|
      if @doctor.save && user.update(user_params)
        format.html do
          flash[:notice] = 'El elemento ha sido guardado correctamente.'
          redirect_to doctors_path
        end
        format.json { render :show, status: :created, location: @doctor }
      else
        format.html do
          flash[:alert] = 'Ocurrió un error al guardar el elemento. Por favor revise la información.'
          render :new
        end
        format.json { render json: @doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    user = User.find(params[:doctor][:user_id])
    respond_to do |format|
      if @doctor.update(doctor_params) && user.update(user_params)
        format.html do
          flash[:notice] = 'El elemento ha sido guardado correctamente.'
          redirect_to doctors_path
        end
        format.json { render :show, status: :ok, location: @doctor }
      else
        format.html do
          flash[:alert] = 'Ocurrió un error al guardar el elemento. Por favor revise la información.'
          render :edit
        end
        format.json { render json: @doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @doctor.destroy
    respond_to do |format|
      format.html do
        flash[:notice] = "El elemento ha sido eliminado correctamente"
        redirect_to doctors_url
      end
      format.json { head :no_content }
    end
  end

  def _form; end

  private

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end

  def doctor_params
    params.require(:doctor).permit(:user_id, :work_center_id, :cedula, :status)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :mother_last_name)
  end
end
