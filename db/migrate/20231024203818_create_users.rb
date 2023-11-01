class CreateUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :users do |t|
      t.string :name
      t.boolean  :es_admin, default: false
      t.timestamps
    end
  end
end
