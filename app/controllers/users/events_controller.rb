class Users::EventsController < ApplicationController
  before_action :load_user
  before_action :load_event, only: [:edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html
      format.json do
        render json: @user.assigned_events.for_full_calendar(params)
      end
    end
  end

  def create
    event = Event.new(event_params)
    event.created_by_id = @user.id
    event.assigned_to_id = @user.id
    respond_to do |format|
      if event.save
        format.html do
          flash[:notice] = 'El elemento fue guardado correctamente.'
          redirect_to user_events_path @user
        end
        format.json do
          render json: event
        end
      else
        format.html do
          flash[:notice] = 'El elemento fue guardado correctamente.'
          redirect_to user_events_path @user
        end
        format.json do
          render json: event.errors.to_json, status: :unprocessable_entity
        end
      end
    end
  end

  def edit
    render partial: 'users/events/form', locals: { user: @user, event: @event }
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html do
          flash[:notice] = 'El elemento ha sido guardado correctamente.'
          redirect_to user_events_path @user
        end
        format.json do
          render json: @event
        end
      else
        format.html do
          flash[:alert] = 'El elemento no pude ser actualizado, por favor revise la información'
          redirect_to user_events_path @user
        end
        format.json do
          render json: @event.errors.to_json, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html do
        flash[:notice] = 'El elemento fue eliminado correctamente.'
        redirect_to user_events_path @user
      end
      format.json do
        render json: @event
      end
    end
  end

  def _form; end

  private

  def load_user
    @user = User.find(params[:user_id])
  end

  def load_event
    @event = @user.assigned_events.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:starts_at, :ends_at, :title, :description, :event_type_id)
  end
end