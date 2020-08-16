class HospitalDoctor < ApplicationRecord
  belongs_to :hospital
  belongs_to :doctor
  has_many :schedules
  has_many :bookings
end
