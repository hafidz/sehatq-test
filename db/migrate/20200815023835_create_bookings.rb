class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.integer :user_id
      t.integer :schedule_id
      t.datetime :booking_date
      t.integer :queue_number
      t.integer :hospital_doctor_id

      t.timestamps
    end
  end
end
