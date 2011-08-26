module ApplicationHelper
  def body_classes
    @body_classes ||= [controller.controller_name]
  end
  
  def markdown(text)
    options = [:hard_wrap, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
    syntax_highlighter(Redcarpet.new(text, *options).to_html).html_safe
  end
  
  def safe_markdown(text)
    options = [:hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
    syntax_highlighter(Redcarpet.new(text, *options).to_html).html_safe
  end
  
  def syntax_highlighter(html)
    doc = Nokogiri::HTML(html)
    doc.search("//pre[@lang]").each do |pre|
      pre.replace Albino.colorize(pre.text.rstrip, pre[:lang])
    end
    doc.to_s
  end
  
  def show_sidebar_module?(name)
    self.active_module?(name) && Settings.get("#{name}:in_nav?") 
  end
  
  def active_module?(name)
    Settings.get("#{name}:enabled?")
  end
  
  def active_class_for_path(classname, path)
    return classname if path == request.path
  end
  
  def root?
    request.url == root_url
  end
  
  def map(address)
    address = address.gsub("\n", " ")
    image_url = "http://maps.googleapis.com/maps/api/staticmap?center=#{address}&markers=#{address}&zoom=14&size=350x100&sensor=false"
    link_url = "http://maps.google.co.uk/maps?q=#{address}"
    link_to image_tag(image_url, :class => "map"), link_url, :target => "_blank"
  end
  
  def eventbrite_tickets(id) 
    "<iframe  src='http://www.eventbrite.com/tickets-external?eid=#{id}&ref=etckt' frameborder='0' height='500px' width='100%' vspace='0' hspace='0' marginheight='5' marginwidth='5' scrolling='auto' allowtransparency='true' id='eventbriteframe'></iframe>".html_safe
  end
end
