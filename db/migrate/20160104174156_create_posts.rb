class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :subgreen_id
      t.string :title
      t.string :url_link
      t.text :body
      t.integer :up_vote
      t.integer :down_vote

      t.timestamps null: false
    end
    change_column(:posts, :up_vote, :integer, { default: 0 })
    change_column(:posts, :down_vote, :integer, { default: 0 })
  end
end
