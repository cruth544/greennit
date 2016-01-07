class CreateUsersSubgreensJoinTable < ActiveRecord::Migration
  def change
    create_join_table :users, :subgreens
  end
end
