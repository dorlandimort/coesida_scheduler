class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :created_events, class_name: 'Event', foreign_key: 'created_by_id'
  has_many :assigned_events, class_name: 'Event', foreign_key: 'assigned_to_id'

end
