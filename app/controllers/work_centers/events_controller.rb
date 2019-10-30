class WorkCenters::EventsController < ApplicationController
  before_action :load_work_center

  def index
    respond_to do |format|
      format.json do
        render json: @work_center.events.for_full_calendar(params)
      end
    end
  end

  private

  def load_work_center
    @work_center = WorkCenter.find(params[:work_center_id])
  end
end