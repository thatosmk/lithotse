
class Agg
  include Mongoid::Document
  include Mongoid::Timestamps

  field :role, type: String
  field :department, type: String
  field :patients, type: String
  field :date, type: String
  field :weight, type: String
  field :temp, type: String
end
