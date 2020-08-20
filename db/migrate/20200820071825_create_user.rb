class CreateUser < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :profile
      t.string :email
      t.timestamps
    end
  end
end
