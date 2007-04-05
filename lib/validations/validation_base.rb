module Validatable
  class ValidationBase #:nodoc:
    attr_accessor :attribute, :message
    attr_reader :level, :groups
    
    def initialize(attribute, options={})
      @attribute = attribute
      @message = options[:message]
      @conditional = options[:if] || Proc.new { true }
      @times = options[:times]
      @level = options[:level] || 1
      @groups = options[:groups].is_a?(Array) ? options[:groups] : [options[:groups]]
    end
    
    def should_validate?(instance)
      instance.instance_eval(&@conditional) && validate_this_time?
    end
    
    def validate_this_time?
      return true if @times.nil?
      @times -= 1
      @times >= 0
    end
  end
end