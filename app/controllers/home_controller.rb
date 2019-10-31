class HomeController < ApplicationController

  def index
    if current_user.has_any_role? Role.super_role, Role.admin_role
      redirect_to events_path
    elsif current_user.has_role? Role.receptionist_role
      redirect_to work_center_events_path(current_user&.receptionist&.work_center)
    elsif current_user.has_role? Role.doctor_role
      redirect_to user_events_path(current_user)
    else
      render plain: 'Not Found', status: :not_found
    end
  end
end