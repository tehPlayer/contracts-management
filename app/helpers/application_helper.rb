module ApplicationHelper
  def convert_flash_key(key)
    case key
    when 'alert' then 'danger'
    when 'notice' then 'success'
    else 'info'
    end
  end
end
