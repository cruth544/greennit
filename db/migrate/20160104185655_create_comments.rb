class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :post_id
      t.string :picture
      t.text :body
      t.integer :up_vote
      t.integer :down_vote

      t.timestamps null: false
    end
    change_column(:comments, :up_vote, :integer, { default: 0 })
    change_column(:comments, :down_vote, :integer, { default: 0 })
  end
end
