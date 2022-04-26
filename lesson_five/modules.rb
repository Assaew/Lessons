module Company
  def title=(name)
    self.company_name = name
  end

  def company_title
    company_name
  end

  protected

  attr_accessor :company_name
end

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module InstanceMethods
    private

    def register_instance
      if self.class.instances.nil?
        self.class.instances = 1
      else
        self.class.instances += 1
      end
    end
  end

  module ClassMethods
    attr_accessor :instances
  end
end
