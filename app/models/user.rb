class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
  has_many :created_events, class_name: 'Event', foreign_key: 'created_by_id'
  has_many :assigned_events, class_name: 'Event', foreign_key: 'assigned_to_id'

  scope :unassigned, lambda {
    joins("LEFT JOIN managers m on m.user_id = users.id
      LEFT JOIN doctors d on d.user_id = users.id
      LEFT JOIN receptionists r on r.user_id = users.id")
      .where('m.user_id IS NULL AND d.user_id IS NULL AND r.user_id IS NULL')
  }

  def full_name
    "#{self.first_name} #{self.last_name} #{self.mother_last_name}"
  end

  def active_for_authentication?
    super && self.status? or self.has_role? :SUPER
  end

  def inactive_message
    "Su cuenta no tiene permisos para iniciar sesión"
  end
end
