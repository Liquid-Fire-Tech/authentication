class CreateAuthenticationUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :authentication_users do |t|
      t.string :email, null: false
      t.string :password, null: false
      t.string :name
      t.string :phone_number

      t.timestamps
    end
  end
end
