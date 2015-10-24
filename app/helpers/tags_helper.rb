module TagsHelper
  def color_alias(value)
    return case value
      when "gray"   then "default"
      when "blue"   then "primary"
      when "green"  then "success"
      when "sky"    then "info"
      when "orange" then "warning"
      when "red"    then "danger"
      else "default"
    end
  end
end
