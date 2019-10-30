class Event < ApplicationRecord
  belongs_to :event_type
  belongs_to :created_by, class_name: 'User'
  belongs_to :assigned_to, class_name: 'User', optional: true

  scope :starting_at, -> start_date { where("starts_at >= :start_date", start_date: start_date) }
  scope :ending_at, -> end_date { where("ends_at <= :end_date", end_date: end_date) }

  scope :for_full_calendar, -> params {
    if params[:start] && params[:end]
      starting_at(params[:start].to_date.strftime('%Y-%m-%d %H:%M'))
          .ending_at(params[:end].to_date.strftime('%Y-%m-%d %H:%M'))
          .order(:starts_at)
    else
      order(:starts_at)
    end
  }
end
