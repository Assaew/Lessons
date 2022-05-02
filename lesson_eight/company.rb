module Company
  attr_accessor :company_name

  def company_name=(name)
    @company_name = name.capitalize
  end
end
