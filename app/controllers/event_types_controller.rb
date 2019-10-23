class EventTypesController < ApplicationController
  before_action :load_event_type, only: [:edit, :update]

  def index
    respond_to do |format|
      format.html
      format.json {
        render json: EventTypeDatatable.new(params, view_context: view_context)
      }
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
      return
    else
      flash[:alert] = "Ocurrió un error. Por favor revise la información"
      render 'new'
      return
    end
  end

  def edit

  end

  def update
    if @event_type.update(event_type_params)
      flash[:notice] ="El elemento ha sido guardado correctamente"
      redirect_to event_types_path
      return
    else
      flash[:alert] = "Ocurrió un error. Por favor revise la información"
      render 'edit'
      return
    end
  end

  def _form

  end

  private

  def load_event_type
    @event_type = EventType.find(params[:id])
  end

  def event_type_params
    params.require(:event_type).permit(:name, :description, :color)
  end
end
