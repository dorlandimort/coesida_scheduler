class DoctorFiltersController < ApplicationController

  def index
    respond_to do |format|
      format.json {
        render json: DoctorFilter.build_select_data(params[:work_centers])
      }
    end
  end

end