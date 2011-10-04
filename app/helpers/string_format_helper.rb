module StringFormatHelper

  def format_address_from_delimited_string(string, delimiter)
    address_parts = string.split(';')
    address = ''
    address_parts.each_with_index do |address_part, index|
      address_part = insert_dash_in_postal_code(camel_case(address_part.downcase))
      address_part = address_part.upcase if index == 2
      address += address_part + ' '
      address += '<br>' if index % 2 == 0
    end
    address
  end

  def format_phone_number_from_string(string)
    phone_number = string.gsub!(/(^\d{3})(\d{3})(\d{4})/, '(\1) \2-\3')
    phone_number
  end

  def insert_dash_in_postal_code(postal_code)
    postal_code.gsub!(/(^\d{5})(\d{4})/, '\1-\2')
    postal_code
  end

  def camel_case(phrase)
    phrase.gsub!(/^\w|\s+\w/) { |a| a.upcase }
    phrase.gsub!(/\s/, ' ')
    phrase
  end

  def bankruptcy_status_code_to_s(code)
    return code if code.nil?
    code.sub('C', 'Completed').sub('A', 'Active')
  end

  def days_delinquent_as_range(days)
    if(days <= 0)
      return 'Current'
    elsif(days > 0 and days <= 30)
      return '0-30'
    elsif(days > 30 and days <= 60)
      return '30-60'
    elsif(days > 60 and days <= 90)
      return '60-90'
    elsif(days > 90 and days <= 120)
      return '90-120'
    else
      return '120+'
    end
  end

#SPO	Short Sale
#MI	Short Sale
#SS	Short Sale
#MODF	Modification
#RPP	Repayment Plan
#MODFF	Hamp Modification
#HAMP	Hamp Modification
#HAFS	HAFA - Short Sale
#HAFD	HAFA - Deed in Lieu
#DIL	Deed in Lieu
#HMPUE	Hamp Modification
#DIL2	Deed in Lieu
#MOD2	Modification
#PAYOFF	Paid In Full
#IRP	Informal Repayment Plan
#MOD	Modification
#HAMPF	Hamp Modification

  
  def loss_mitigation_path_in_words(path)
    return 'None' if path.nil?
    path.gsub(/DIL.*/, 'Deed in Lieu').
          gsub(/HAFS/, 'HAFA Short Sale').
          gsub(/HAFD/, 'HAFA Deed in Lieu').
          gsub(/HA?MP\w*/, 'Hamp Modification').
          gsub(/IRP/, 'Informal Repayment Plan').
          gsub(/MODFF/, 'Hamp Modification').
          gsub(/MOD\w*/, 'Modification').
          gsub(/PAYOFF/, 'Paid In Full').
          gsub(/RPP/, 'Repayment Plan').
          gsub(/SPO/, 'Short Sale').
          gsub(/SS/, 'Short Sale').
          gsub(/MI/, 'Short Sale')
  end

  def loss_mitigation_path_status_in_words(status)
      return 'None' if status.nil?
      status.gsub(/A/, 'Active').
          gsub(/R|S/, 'Suspended')
  end

end