class CreateAppointmentsDogs < ActiveRecord::Migration[7.1]
  def change
    create_table :appointments_dogs do |t|
      t.references :dog, null: false, foreign_key: true
      t.references :appointment, null: false, foreign_key: true

      t.timestamps
    end

    add_index :appointments_dogs, [:dog_id, :appointment_id], unique: true

  end
end
