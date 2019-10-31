module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    # Define custom handlers
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ActiveRecord::RecordNotFound, with: :four_o_four
    rescue_from ActionController::RoutingError, with: :four_o_four
  end

  private

  def four_twenty_two(e)
    respond_to do |format|
      format.html do
        redirect_to not_found_path
      end
      format.json do
        render json: { message: e.message, status: :unprocessable_entity }
      end
    end
  end

  def four_o_four(e)
    respond_to do |format|
      format.html do
        redirect_to not_found_path
      end
      format.json do
        render json: { message: e.message }, status: :not_found
      end
    end
  end
end