module Validatable
  def validates(column, options = {})
    @to_validate = {} if @to_validate.nil?
    @to_validate[column] = options
  end

  def valid?(object)
    return true if @to_validate.nil?
    @to_validate.all? do |column, validation|
      instance_value = object.send(column)


      if !validation[:presence].nil?
        validation[:presence] == !instance_value.nil?
      elsif !validation[:uniquness].nil?
        all_instances = self.all

        all_instances.all? do |instance|
          instance_value = instance.send(column)
        end
      elsif !validation[:length].nil?
        check = validation[:length].first[0]
        param = validation[:length][check]

        case check
        when :maximum
          instance_value.length <  param
        when :minimum
          instance_value.length >= param
        when :in
          instance_value.length <  param.max &&
          instance_value.length >= param.min
        end
      end
    end
  end
end