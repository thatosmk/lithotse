require './models/aggs'
require './models/health_record'

module Aggregator
  class Consolidate
    attr_reader :roles
    
    def initialize
      @roles = %w[Operations Internal Care Emergency Communications Finance]
    end

    def role_columns
      all_columns = []
      @roles.each do |role|
        columns_per_role = { role: nil, columns: []}
        columns_per_role['role'] = role

        case role
          when "Operations"
            columns_per_role['columns'] = %w[id weight temp]
          when "Care"
            columns_per_role['columns'] =%w[id date weight temp]
        end
        all_columns << columns_per_role
      end
      all_columns
    end

    def populate
      HealthRecord.all.each do |record|
        @roles.map { |role| aggregate_per_department(role, record) }
      end
    end

    def self.update(document)
      # TODO: append to ROLE new information from document
      roles = %w[Operations Internal Care Emergency Communications Finance]
      roles.map { |role| aggregate_per_department(role, document) }
    end

    def aggregate_per_department(role, document)
      case role
        when "Operations"
          # pick the relevant fields to aggregate for this role
          Agg.create!(role: role, department: document.department.name)
        when "Care"
          # pick the relevant fields to aggregate for this role
          Agg.create!(role: role, date: Date.today, weight: document.weight, temp: document.temperature)
      end
    end
  end

  class ViewHelper
    def render(role)
      # TODO: return a hash of data aggregations associated with the role
    end
  end
end
