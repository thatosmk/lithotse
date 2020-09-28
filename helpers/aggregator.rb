module Aggregator
  class Consolidate

    def self.update_patient(document)
      # TODO: append to ROLE new information from document
      patient = Patient.where(id_number: document.id_number).first

    end
  end

  class ViewHelper
    def render(role)
      # TODO: return a hash of data aggregations associated with the role
    end
  end
end
