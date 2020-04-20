require 'pry'

module Validate
  def self.included(base)
    base.extend         ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :params

    def validate(name, options={})
      self.params ||= {}
      self.params[:name] = name
      options.each do |key, value|
        self.params[:key] = key
        self.params[:value] = value
      end
    end
  end

  module InstanceMethods
    def field_name
      v = v.to_s.delete '@'
      name = self.class.params[:name].to_s
      self.instance_variable_get("@#{v}".to_sym) if v = name
    end

    def validate!
      case self.class.params[:key]
      when :presence
        validate_presence(field_name, self.class.params)
      when :type
        validate_type(field_name, self.class.params)
      when :format
        validate_format(field_name, self.class.params[:value])
      when :absence
        validate_absence(field_name, self.class.params)
      end
    end

    def valid?
      validate!
      true
    rescue StandartError
      false
    end

    private

    def validate_presence(name, options)
      raise "#{options[:name].to_s.capitalize!} can\'t be empty!" if name_valid?(name)
    end

    def validate_format(name, options)
      raise "#{name} has invalid format" if number_valid?(name, options)
    end

    def validate_type(name, options)
      raise 'Invalid class' unless type_valid?(name, options)
    end

    def validate_absence(name, options)
      raise "#{options[:name].to_s.capitalize!} must be blank!" if name_present?(name)
    end

    def name_valid?(name)
      name.to_s.strip.empty?
    end

    def name_present?(name)
      !name.to_s.strip.empty?
    end

    def number_valid?(name, options)
      name !~ Regexp.new(options)
    end

    def type_valid?(name, options)
      name == options[:value]
    end
  end
end
