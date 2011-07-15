class AddSamplePost < ActiveRecord::Migration
  def up
    post = Post.new
    post.title = "Purus Amet Sollicitudin Egestas"
    post.content = "Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Nullam quis risus eget urna mollis ornare vel eu leo. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Nulla vitae elit libero, a pharetra augue. Praesent commodo cursus magna, vel scelerisque nisl consectetur et."
    post.published_at = Time.now
    post.save
  end

  def down
  end
end
