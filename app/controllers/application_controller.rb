class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # layout :layout_by_resource

  # def layout_by_resource
  #   devise_controller? ? "devise" : "application"
  # end

end
