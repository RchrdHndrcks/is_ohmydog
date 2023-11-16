class CreateDog < ActiveRecord::Migration[7.1]
  def change
    create_table :dogs do |t|
      t.string :name
      t.timestamps
      t.belongs_to :user, foreign_key: true
      t.string :breed
      t.datetime :birthdate
      t.string :image
      t.string :colour
      t.string :observations
    end
  end
end
