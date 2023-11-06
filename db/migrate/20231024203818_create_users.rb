class CreateUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :identifier_number
      t.string :last_name
      t.string :address
      t.string :phone_number
      t.boolean :es_admin, default: false
      t.timestamps
    end
  end
end
