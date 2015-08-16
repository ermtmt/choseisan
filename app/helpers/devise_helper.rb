module DeviseHelper
  def devise_error_messages!
    return "" unless defined? resource
    return "" if resource.errors.empty?
    html = <<-EOS
      <div class="alert alert-danger">
        <ul>
    EOS
    resource.errors.full_messages.each do |msg|
      html += <<-EOS
        <li>#{msg}</li>
      EOS
    end
    html += <<-EOS
        </ul>
      </div>
    EOS
    html.html_safe
  end

  def devise_error_messages?
    resource.errors.empty? ? false : true
  end
end

