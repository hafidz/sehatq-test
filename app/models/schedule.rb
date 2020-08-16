class Schedule < ApplicationRecord
  belongs_to :hospital_doctor
  has_many :bookings
end
