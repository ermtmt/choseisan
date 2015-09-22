module TagsHelper
  def color_alias(value)
    return case value
      when 0 then "default"
      when 1 then "primary"
      when 2 then "success"
      when 3 then "info"
      when 4 then "warning"
      when 5 then "danger"
      else "default"
    end
  end
end
