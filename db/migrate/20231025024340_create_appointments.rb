# db/migrate/[timestamp]_create_appointments.rb
class CreateAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.belongs_to :user, foreign_key: true
      t.integer :state, default: 0
      t.integer :timeSlot, default: 0
      t.datetime :appointment_date
      t.timestamps
    end
  end
end