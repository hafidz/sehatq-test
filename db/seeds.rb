numbers = ["Satu", "Dua", "Tiga", "Empat", "Lima", "Enam", "Tujuh", "Delapan", "Sembilan", "Sepuluh"]
# Apikey
if ApiKey.first.blank?
  ActiveRecord::Base.connection.execute("TRUNCATE table api_keys")
  puts 'seeding table api_keys . . .'
  ApiKey.create!(client_key: SecureRandom.hex)
else
  puts "not seeding Apikey table"
end

# Hospital
if Hospital.first.blank?
  ActiveRecord::Base.connection.execute("TRUNCATE table hospitals")
  puts 'seeding table hospitals . . .'
  numbers[0..4].map { |number| 
    Hospital.create!(name: "Rumah Sakit #{number}")
  }
else
  puts "not seeding Hospital table"
end

# Doctor
if Doctor.first.blank?
  ActiveRecord::Base.connection.execute("TRUNCATE table doctors")
  puts 'seeding table doctors . . .'
  numbers.map { |number| 
    Doctor.create!(name: "Dokter #{number}")
  }
else
  puts "not seeding Doctor table"
end

# Hospital Doctor
if HospitalDoctor.first.blank?
  ActiveRecord::Base.connection.execute("TRUNCATE table hospital_doctors")
  puts 'seeding table hospital_doctors . . .'
  hospitals = Hospital.pluck(:id)
  hospitals.each_with_index do |hospital, idx|
    HospitalDoctor.create!(hospital_id: hospital, doctor_id: idx + 1)
  end
  hospitals.each_with_index do |hospital, idx|
    HospitalDoctor.create!(hospital_id: hospital, doctor_id: idx + 6)
  end
else
  puts "not seeding Hospital table"
end

# User
if User.first.blank?
  ActiveRecord::Base.connection.execute("TRUNCATE table users")
  puts 'seeding table users . . .'
  numbers.map { |number| 
    User.create!(full_name: "User #{number}", password: "12345678", password_confirmation: "12345678", auth_token: User.generate_token, email: "user#{number.downcase}@test.com")
  }
else
  puts "not seeding User table"
end

# Schedule
if Schedule.first.blank?
  ActiveRecord::Base.connection.execute("TRUNCATE table schedules")
  puts 'seeding table schedules . . .'
  hospital_doctors = HospitalDoctor.pluck(:id)
  hospital_doctors.each_with_index do |hospital_doctor, idx|
    start_date = DateTime.parse("#{Date.today.strftime('%Y-%m-%d')}")
  	idx += 1

    Schedule.create!(hospital_doctor_id: hospital_doctor, schedule_date: start_date + idx.hours)
  end
else
  puts "not seeding schedules table"
end

