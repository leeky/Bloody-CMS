xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title Settings.get("events:title")
    xml.link events_url(:rss)
    
    for event in @events
      xml.item do
        xml.title event.title
        xml.description markdown(event.description)
        xml.pubDate event.published_or_created_at.to_s(:rfc822)
        xml.link event_url(event, :rss)
        xml.guid event_url(event, :rss)
      end
    end
  end
end