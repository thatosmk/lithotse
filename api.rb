# author: Thato Semoko
# REST API

require 'sinatra'
require 'sinatra/namespace'
require 'mongoid'
require './models/patient'
require './models/department'
require './models/health_record'
require './helpers/api_helper'


# DB Setup
Mongoid.load!(File.join(File.dirname(__FILE__), 'config', 'mongoid.yml'))

# Endpoints
get '/' do
  @departments = Department.all
  if params['department']
    @records = Department.where(name: "#{params['department']}").first.health_records
  elsif params['id_number']
    @records = HealthRecord.where(id_number: "#{params['id_number']}")
    @patient = Patient.where(id_number: "#{params['id_number']}").first
  else
    @records = HealthRecord.all
  end
  erb :index, locals: { records: @records, departments: @departments, patient: @patient }
end

get '/insights' do
  @departments = Department.all
  @roles = %w[Operations Internal Care Emergency Communications Finance]
  if params['role']
  end
  erb :insights, locals: { roles: @roles, departments: @departments, patient: @patient }
end

namespace '/api/v1' do

  # respond_to :json
  before do
    content_type 'application/json'
  end

  # GET /patients
  get '/patients' do
    Patient.all.to_json
  end


  # GET /patients/:id
  get '/patients/:id' do |id|
    patient = Patient.where(id: id).first
    halt(404, { message: 'Patient not found'}.to_json) unless patient
    patient.to_json
    status 302
  end

  # POST /patients
  post '/patients' do
    patient = Patient.new(patient_params)
    
    if patient.save
      response.headers['Location'] = "#{base_url}/api/v1/patients/#{patient.id}"
      status 201 # created
    else
      status 422 # unprocessable entity
    end
  end

  # PUT /patients
  put '/patients/:id' do |id|
    patient = Patient.where(id: id).first
    halt(404, { message: 'Patient not found'}.to_json) unless patient
    if patient.update_attributes(patient_params)
      status 204
    else
      status 422 # unprocessable entity
    end
  end

  # DELETE /patients
  delete 'patients/:id' do |id|
    patient = Patient.where(id: id).first
    patient.destroy if patient
    status 204
  end

  # GET /health_records
  get '/health_records' do
    HealthRecord.all.to_json
  end


  # GET /health_records/:id
  get '/health_records/:id' do |id|
    health_record = HealthRecord.where(id: id).first
    halt(404, { message: 'Patient not found'}.to_json) unless health_record
    health_record.to_json
    status 302
  end

  # POST /health_records
  post '/health_records' do
    health_record = HealthRecord.new(record_params)
    
    if health_record.save
      response.headers['Location'] = "#{base_url}/api/v1/health_records/#{health_record.id}"
      status 201 # created
    else
      status 422 # unprocessable entity
    end
  end

  # PUT /health_records
  put '/health_records/:id' do |id|
    health_record = HealthRecord.where(id: id).first
    halt(404, { message: 'health_record not found'}.to_json) unless health_record
    if health_record.update_attributes(record_params)
      status 204
    else
      status 422 # unprocessable entity
    end
  end

  # DELETE /health_records
  delete 'health_records/:id' do |id|
    health_record = HealthRecord.where(id: id).first
    health_record.destroy if health_record
    status 204
  end
end
