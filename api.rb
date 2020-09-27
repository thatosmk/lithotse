# author: Thato Semoko
# REST API

require 'sinatra'
require 'sinatra/namespace'

# Endpoints
get '/' do
  'Welcome to the AI'
end


namespace '/api/v1' do

  # GET /patients
  get '/patients' do
    'gets patients'
  end


  # GET /patients/:id
  get '/patients/:id' do |id|
    'gets patients #{id}'
  end

  # POST /patients

  # PUT /patients

  # DELETE /patients
end
