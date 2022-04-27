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
