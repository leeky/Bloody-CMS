xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Articles"
    xml.description "Lots of articles"
    xml.link posts_url(:rss)
    
    for post in @posts
      xml.item do
        xml.title post.title
        xml.description markdown(post.content)
        xml.pubDate post.published_or_created_at.to_s(:rfc822)
        xml.link post_url(post, :rss)
        xml.guid post_url(post, :rss)
      end
    end
  end
end