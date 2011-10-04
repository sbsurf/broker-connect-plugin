module DelinquencyOrReoHelper
  def should_use_reo(loan_id)
    reo = RealEstateOwned.find_by_loan_id(loan_id)
    return (!reo.nil? and reo.status_code != 'I')
  end
end