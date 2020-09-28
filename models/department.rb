# author: Thato Semoko

require_relative 'health_record'

class Department
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :telephone, type: String
  field :email, type: String

  index({ name: 'text' }, { unique: true })

  has_many :health_records
end
