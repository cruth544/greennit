class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :username
      t.string :profile_pic

      t.index(:email, unique: true)

      t.timestamps null: false
    end
    change_column(:users, :profile_pic, :string, { default: "app/assets/default-profile-image.jpg" })
  end

end
