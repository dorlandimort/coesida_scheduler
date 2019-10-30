class Doctor < ApplicationRecord
  belongs_to :user
  belongs_to :work_center
  has_many :events, through: :user, source: :assigned_events
end
