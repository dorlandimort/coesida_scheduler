module ApplicationHelper
  def toastr_notifications
    flash_messages = []
    flash.each do |type, message|
      type = 'success' if type == 'notice'
      type = 'error'   if type == 'alert'
      text = "<script>jQuery(document).ready(function() { toastr.#{type}('#{message}'); }); console.log('hola');</script>"
      flash_messages << text.html_safe if message
    end
    flash_messages.join("\n").html_safe
  end
end
