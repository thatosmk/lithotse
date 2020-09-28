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

  index({ id_number: 'text' }, { unique: false })

  belongs_to :department

  after_save do |document|
    Aggregator::Consolidate.update_patient(document)
  end
end
