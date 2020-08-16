class Doctor < ApplicationRecord
  has_many :hospital_doctors
  has_many :hospitals, through: :hospital_doctors

  def self.get_all_doctor
    key = "doctor:all"
    cache_doctor = $redis.get(key) rescue nil
    if cache_doctor == nil
      doctor = HospitalDoctor.all.to_json
      cache_doctor = Marshal.dump(doctor)
      $redis.setex(key, 2000, cache_doctor) 
    else
      doctor = JSON.load cache_doctor
    end
    
    return doctor
  end

  def self.get_doctor_by_hospital_id(hospital_id)
    key = "doctor:all:#{hospital_id}"
    cache_doctor = $redis.get(key) rescue nil
    if cache_doctor == nil
      doctor = HospitalDoctor.where(hospital_id: hospital_id)
      cache_doctor = Marshal.dump(doctor)
      $redis.setex(key, 2000, cache_doctor) 
    else
      doctor = Marshal.load(cache_doctor)
    end
    
    return doctor
  end
end
