class AppointmentsDog < ApplicationRecord
  belongs_to :dog
  belongs_to :appointment
end
