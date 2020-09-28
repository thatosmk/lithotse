require 'faker'
require 'mongoid'
require './models/patient'
require './models/department'
require './models/health_record'

# DB Setup
Mongoid.load!(File.join(File.dirname(__FILE__),  'mongoid.yml'), :development)

1.upto(5) do
  Patient.create!(id_number: Faker::IDNumber.unique.south_african_id_number, first_name: Faker::Name.unique.first_name, last_name: Faker::Name.last_name, telephone: Faker::PhoneNumber.phone_number, email: Faker::Internet.unique.email, male?: "No", dead?: DateTime.now)
end

1.upto(5) do
  d = Department.create!(name: Faker::Commerce.unique.department, telephone: Faker::PhoneNumber.phone_number, email: Faker::Internet.unique.email)

  # add health records
  1.upto(5) do
    HealthRecord.create!(department_id: d.id, id_number: Faker::IDNumber.unique.south_african_id_number, weight: "#rand(20..90)", temperature: "#{rand(30..50)}", appointment_time: DateTime.now, notes: "Patient is stabe", diagnosis: Faker::Company.bs) 
  end
end
