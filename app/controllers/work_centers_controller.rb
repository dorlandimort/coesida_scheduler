class WorkCentersController < ApplicationController
  before_action :set_work_center, only: [:show, :edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html { @work_centers = WorkCenter.all }
      format.json {
        render json: WorkCenterDatatable.new(params, view_context: view_context)
      }
    end
  end

  def show; end

  def new
    @work_center = WorkCenter.new
  end

  def edit; end

  def create
    @work_center = WorkCenter.new(work_center_params)

    respond_to do |format|
      if @work_center.save
        format.html {
          flash[:notice] = "El elemento ha sido guardado correctamente"
          redirect_to work_centers_path
        }
        format.json { render :show, status: :created, location: @work_center }
      else
        format.html {
          flash[:alert] = "Ocurrió un error al guardar el elemento, por favor verifique la información"
          render :new
        }
        format.json { render json: @work_center.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @work_center.update(work_center_params)
        format.html {
          flash[:notice] = "El elemento ha sido guardado correctamente"
          redirect_to work_centers_path
        }
        format.json { render :show, status: :ok, location: @work_center }
      else
        format.html {
          flash[:alert] = "Ocurrió un error al guardar el elemento, por favor verifique la información"
          render :edit
        }
        format.json { render json: @work_center.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @work_center.destroy
    respond_to do |format|
      format.html { redirect_to work_centers_url, notice: 'Work center was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def _form

  end

  private

  def set_work_center
    @work_center = WorkCenter.find(params[:id])
  end

  def work_center_params
    params.require(:work_center).permit(:name, :short_name, :description, :address, :status)
  end
end
