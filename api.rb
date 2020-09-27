# author: Thato Semoko
# REST API

require 'sinatra'
require 'sinatra/namespace'
require 'mongoid'
require './models/patient'
require './helpers/api_helper'


# DB Setup
Mongoid.load!(File.join(File.dirname(__FILE__), 'config', 'mongoid.yml'))

# Endpoints
get '/' do
  'Welcome to the AI'
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
    status 301
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

  # DELETE /patients
end
