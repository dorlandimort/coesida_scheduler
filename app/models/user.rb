class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
  has_many :created_events, class_name: 'Event', foreign_key: 'created_by_id'
  has_many :assigned_events, class_name: 'Event', foreign_key: 'assigned_to_id'

  def active_for_authentication?
    super && self.status? or self.has_role? :SUPER
  end

  def inactive_message
    "Su cuenta no tiene permisos para iniciar sesión"
  end
end
