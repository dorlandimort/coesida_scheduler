class EventTypesController < ApplicationController
  before_action :load_event_type, only: %i[edit update]

  def index
    respond_to do |format|
      format.html
      format.json do
        render json: EventTypeDatatable.new(params, view_context: view_context)
      end
    end
  end

  def new
    @event_type = EventType.new
  end

  def create
    @event_type = EventType.new(event_type_params)
    if @event_type.save
      flash[:notice] = "El elemento ha sido guardado correctamente"
      redirect_to event_types_path
    else
      flash[:alert] = "Ocurrió un error. Por favor revise la información"
      render 'new'
    end
  end

  def edit; end

  def update
    if @event_type.update(event_type_params)
      flash[:notice] ="El elemento ha sido guardado correctamente"
      redirect_to event_types_path
    else
      flash[:alert] = "Ocurrió un error. Por favor revise la información"
      render 'edit'
    end
  end

  def _form; end

  private

  def load_event_type
    @event_type = EventType.find(params[:id])
  end

  def event_type_params
    params.require(:event_type).permit(:name, :description, :color, :duration, :status)
  end
end
