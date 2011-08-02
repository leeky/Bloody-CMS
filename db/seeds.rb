# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Page.create(:title => "Home", 
            :sidebar_title => 'home', 
            :show_in_sidebar => false, 
            :content => "This is your first page. You can now add more pages, a blog, and much more.", 
            :published_at => Time.now)
            
Post.create(:title => "Your first post", 
            :content => "This is your first post. You can now add more posts or delete this one.", 
            :published_at => Time.now)
            
Option.set("root:header_image", "bloody_cms.png")
Option.set("pages:in_nav?", true)
Option.set("root", "posts#index")
Option.set("pages:enabled?", true)
Option.set("cookies_secret_token", ActiveSupport::SecureRandom.hex(64))
Option.set('root_url', "pages#home")
Option.set('home:sidebar_title', "home")
Option.set('home:enabled?', true)
Option.set('home:in_nav?', true)
Option.set('blog:enabled?', false)
Option.set('blog:path', "blog")


