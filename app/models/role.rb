class Role < ApplicationRecord
  has_and_belongs_to_many :users, :join_table => :users_roles

  belongs_to :resource,
             :polymorphic => true,
             :optional => true

  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true
  scopify

  scope :displayable, -> { where.not(name: 'SUPER') }

  def self.super_role
    :SUPER
  end

  def self.receptionist_role
    :RECEPCIONISTA
  end

  def self.doctor_role
    :MEDICO
  end

  def self.manager_role
    :RESPONSABLE
  end

  def self.admin_role
    :ADMINISTRADOR
  end
end
