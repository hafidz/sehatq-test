class CreateHospitalDoctors < ActiveRecord::Migration[5.0]
  def change
    create_table :hospital_doctors do |t|
      t.integer :hospital_id
      t.integer :doctor_id

      t.timestamps
    end
  end
end
