class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :additional_attributes, :event_type,
             :color, :start, :end, :textColor
  #belongs_to :created_by
  belongs_to :assigned_to

  def start
    self.object.starts_at.strftime('%Y-%m-%d %H:%M')
  end

  def end
    self.object.ends_at.strftime('%Y-%m-%d %H:%M')
  end

  def color
    self.object.event_type.color
  end

  def textColor
    self.object.event_type.text_color
  end
end
