# author: Thato Semoko

require_relative 'department'
require './helpers/aggregator'

class HealthRecord
  include Mongoid::Document
  include Mongoid::Timestamps

  field :department_id, type: String
  field :id_number, type: String
  field :notes, type: String
  field :examiner, type: String
  field :diagnosis, type: String
  field :weight, type: String
  field :temperature, type: String
  field :appointment_time, type: String

  index({ id_number: 'text' }, { unique: false })

  belongs_to :department

  after_save do |document|
    Aggregator::Consolidate.update(document)
  end
end
