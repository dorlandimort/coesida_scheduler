class Users::EventsController < ApplicationController
  before_action :load_user

  def index
    respond_to do |format|
      format.html
      format.json {
        render json: @user.events
      }
    end
  end

  private

  def load_user
    @user = User.find(params[:user_id])
  end
end