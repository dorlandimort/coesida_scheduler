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

  def self.filter(events, params)
    if params[:doctors]
      events = events.where(assigned_to_id: params[:doctors][0].split(','))
    end

    if params[:event_types]
      events = events.where(event_type_id: params[:event_types][0].split(','))
    end

    if params[:search_text]
      unless params[:search_text].empty?
        events = events.where("title ilike :search or description ilike :search",
                              search: "%#{params[:search_text]}%")
      end
    end
    events
  end
end
