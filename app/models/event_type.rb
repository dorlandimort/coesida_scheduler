class EventType < ApplicationRecord
  has_many :events
  validates :name, :color, presence: true
  before_save :generate_text_color
  before_update :generate_text_color

  private

  def generate_text_color
    red = self.color[1, 2].to_i(16)
    green = self.color[3, 2].to_i(16)
    blue = self.color[5, 2].to_i(16)
    puts "red: #{red} green: #{green} blue: #{blue}"
    self.text_color = (red * 0.299 + green * 0.587 + blue * 0.114) > 186 ? "#000000" : "#ffffff"
  end
end
