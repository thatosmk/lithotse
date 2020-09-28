# author: Thato Semoko

class Patient
  include Mongoid::Document
  include Mongoid::Timestamps

  field :id_number, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :telephone, type: String
  field :cell, type: String
  field :email, type: String
  field :language, type: String
  field :dead?, type: DateTime
  field :male?, type: String


  index({ id_number: 'text' }, { unique: true })
  index({ email: 'text' }, { unique: true })

  has_many :health_records
end
