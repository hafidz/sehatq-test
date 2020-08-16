class Hospital < ApplicationRecord
  has_many :hospital_doctors
  has_many :doctors, through: :hospital_doctors

  def self.get_all_hospital
    key = "hospital:all"
    cache_hospital = $redis.get(key) rescue nil
    if cache_hospital == nil
      hospital = Hospital.all
      cache_hospital = Marshal.dump(hospital)
      $redis.setex(key, 2000, cache_hospital) 
    else
      hospital = Marshal.load(cache_hospital)
    end
    
    return hospital
  end
end
