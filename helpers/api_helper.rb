require 'csv'

def base_url
  @base_url ||= "#{request.env['rack.url_scheme']}://{request.env['HTTP_HOST']}"
end

def patient_params
  begin
    case request.content_type
      when "application/json"
        parse_json(request.body.read)
      when "application/x-www-form-urlencoded"
        # TODO: turn this into a hash
        parse_csv(request.body.read)
      else
        halt 400, { message:'Content-Type not supported' }.to_json
    end
  rescue
    halt 400, { message:'Invalid File format' }.to_json
  end
end

def parse_json(json_data)
  JSON.parse(json_data)
end

def parse_csv(csv_data)
  CSV.read(csv_data)
end
