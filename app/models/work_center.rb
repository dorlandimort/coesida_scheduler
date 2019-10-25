class WorkCenter < ApplicationRecord

  def status_text
    self.status? ? "Activo" : "Inactivo"
  end

end
