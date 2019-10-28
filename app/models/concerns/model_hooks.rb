module ModelHooks
  extend ActiveSupport::Concern

  included do
    before_save :upcase_attributes
  end

  def upcase_attributes
    self.attributes.each do |attr,val|
      self.send("#{attr}=",val.upcase) if self.upcase_attrs.include?(attr) && ! val.nil?
    end
  end
end