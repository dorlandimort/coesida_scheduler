class WorkCenter < ApplicationRecord
  has_many :doctors
  has_many :receptionists
  has_many :managers
  has_many :events, through: :doctors

  def status_text
    self.status? ? "Activo" : "Inactivo"
  end

end
