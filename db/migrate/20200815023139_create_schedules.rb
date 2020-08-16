class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.integer :hospital_doctor_id
      t.datetime :schedule_date

      t.timestamps
    end
  end
end
