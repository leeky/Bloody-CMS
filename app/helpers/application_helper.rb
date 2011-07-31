module ApplicationHelper
  def body_classes
    @body_classes ||= [controller.controller_name]
  end
  
  def markdown(text)
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
  
  def root?
    request.url == root_url
  end
end
