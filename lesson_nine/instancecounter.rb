module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module InstanceMethods
    private

    def register_instance
      self.class.instances ||= 1
      self.class.instances += 1
    end
  end

  module ClassMethods
    attr_accessor :instances
  end
end