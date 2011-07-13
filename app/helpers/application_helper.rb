module ApplicationHelper
  def body_classes
    @body_classes ||= [controller.controller_name]
  end
end
