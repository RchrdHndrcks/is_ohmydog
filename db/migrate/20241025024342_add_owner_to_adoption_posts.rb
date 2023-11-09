class AddOwnerToAdoptionPosts < ActiveRecord::Migration[7.1]
  def change
    add_reference :adoption_posts, :user, null: false, foreign_key: true
  end
end
