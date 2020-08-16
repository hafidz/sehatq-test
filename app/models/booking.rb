class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :schedule
  belongs_to :hospital_doctor
end
