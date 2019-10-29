class EventsController < ApplicationController
  before_action :load_event, only: [:show, :edit, :update, :destroy]
  def index
    respond_to do |format|
      format.html
      format.json {
        events = Event.all
        events = events.starting_at(params[:start].to_date.strftime('%Y-%m-%d %H:%M'))
                     .ending_at(params[:end].to_date.strftime('%Y-%m-%d %H:%M')).order(:starts_at) unless params[:start].nil? or params[:end].nil?

        render json: events
      }
    end

  end

  def new
    render partial: 'events/form', locals: { event: Event.new }
  end

  def create
    @event = current_user.created_events.new(event_params)
    @event.save
    respond_to do |format|
      format.html {
        if @event.persisted?
          flash[:notice] = "Elemento guardado correctamente"
          redirect_to events_path
        else
          flash[:alert] = "Error al guardar el elemento, verifique los datos"
          render :new
        end
      }
      format.json {
        puts @event.errors.inspect
          render json: @event
      }
    end
  end

  def show

  end

  def edit
    render partial: 'events/form', locals: { event: @event }
  end

  def update
    if @event.update(event_params)
      flash[:notice] = "Elemento guardado correctamente"
      redirect_to events_path
    else
      flash[:alert] = "Error al guardar el elemento, verifique los datos"
      render :edit
    end
  end

  def destroy
    @event.destroy!
    flash[:notice] = "Elemento guardado correctamente"
    redirect_to events_path
  end

  def _form

  end

  private

  def load_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :starts_at, :ends_at, :additional_attributes,
                                  :assigned_to_id, :event_type_id)
  end
end
