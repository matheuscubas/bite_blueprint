# frozen_string_literal: true

class JsonValidator
  SCHEMA = {
    type: "object",
    required: [ "name" ],
    properties: {
      name: {
        type: "string",
      },
      description: {
        type: [ "string", "null" ]
      },
      category: {
        type: [ "string", "null" ]
      },
      menus: {
        type: "array",
        minItems: 1,
        items: {
          type: "object",
          required: [ "name" ],
          properties: {
            name: {
              type: "string",
            },
            description: {
              type: [ "string", "null" ]
            },
            menu_items: {
              type: "array",
              minItems: 1,
              items: {
                type: "object",
                required: [ "name", "price" ],
                properties: {
                  name: {
                    type: "string",
                  },
                  price: {
                    type: [ "number", "string" ],
                    pattern: "^\\d+(\\.\\d{1,2})?$",
                  },
                  description: {
                    type: [ "string", "null" ]
                  }
                }
              }
            }
          }
        }
      }
    }
  }.freeze

  def initialize(json_data)
    @json_data = parse_json(json_data)
    @errors = @json_data ? validate_schema : [ "Invalid JSON input" ]
  rescue JSON::ParserError => e
    @errors = [ "JSON parse error: #{e.message}" ]
    @json_data = nil
  end

  def valid?
    @errors.empty?
  end

  def parsed_json
    @json_data if valid?
  end

  private

  def parse_json(data)
    case data
    when String then JSON.parse(data, symbolize_names: true)
    when Hash then data.deep_symbolize_keys
    else raise ArgumentError, "Input must be JSON string or Hash"
    end
  end

  def validate_schema
    JSON::Validator.fully_validate(
      SCHEMA.deep_stringify_keys,
      @json_data.deep_stringify_keys
    )
  end
end
