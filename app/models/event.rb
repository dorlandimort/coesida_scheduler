class Event < ApplicationRecord
  belongs_to :event_type
  belongs_to :created_by, class_name: 'User'
  belongs_to :assigned_to, class_name: 'User', optional: true

  scope :starting_at, -> start_date { where("starts_at >= :start_date", start_date: start_date) }
  scope :ending_at, -> end_date { where("ends_at <= :end_date", end_date: end_date) }
end
