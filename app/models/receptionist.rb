class Receptionist < ApplicationRecord
  belongs_to :user
  belongs_to :work_center
end
