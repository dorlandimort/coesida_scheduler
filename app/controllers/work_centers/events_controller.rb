class WorkCenters::EventsController < ApplicationController
  before_action :load_work_center
  before_action :load_event, only: :show

  def index
    respond_to do |format|
      format.html
      format.json do
        render json: Event.filter(@work_center.events.includes(:assigned_to, :event_type), params)
                          .for_full_calendar(params)
      end
    end
  end

  def show
    render partial: 'work_centers/events/form', locals: { event: @event }
  end

  def _form; end

  private

  def load_work_center
    @work_center = WorkCenter.find(params[:work_center_id])
  end

  def load_event
    @event = Event.find(params[:id])
  end
end