module SovrenSaas
  class ContactInformation
    attr_accessor :first_name, :middle_name, :last_name, :aristocratic_title, :form_of_address, :generation, :qualification, :address_line_1, :address_line_2, :city, :state, :country, :postal_code, :home_phone, :mobile_phone, :email, :website

    def self.parse(contact_information)
      return nil if contact_information.nil?
      result = self.new
      result.first_name = contact_information.css('hrxml|PersonName hrxml|GivenName',{hrxml:HRXML_NS}).collect(&:text).join(" ")
      result.middle_name = contact_information.css('hrxml|PersonName hrxml|MiddleName',{hrxml:HRXML_NS}).collect(&:text).join(" ")
      result.last_name = contact_information.css('hrxml|PersonName hrxml|FamilyName',{hrxml:HRXML_NS}).collect(&:text).join(" ")
      result.aristocratic_title = contact_information.css('hrxml|PersonName Affix[type=aristocraticTitle]',{hrxml:HRXML_NS}).collect(&:text).join(" ")
      result.form_of_address = contact_information.css('hrxml|PersonName Affix[type=formOfAddress]',{hrxml:HRXML_NS}).collect(&:text).join(" ")
      result.generation = contact_information.css('hrxml|PersonName Affix[type=generation]',{hrxml:HRXML_NS}).collect(&:text).join(" ")
      result.qualification = contact_information.css('hrxml|PersonName Affix[type=qualification]',{hrxml:HRXML_NS}).collect(&:text).join(" ")

      address = contact_information.css('hrxml|PostalAddress hrxml|DeliveryAddress hrxml|AddressLine',{hrxml:HRXML_NS}).collect(&:text)
      result.address_line_1 = address[0] if address.length > 0
      result.address_line_2 = address[1] if address.length > 1
      result.city = contact_information.css('hrxml|PostalAddress',{hrxml:HRXML_NS}).first.css('hrxml|Municipality',{hrxml:HRXML_NS}).text rescue nil
      result.state = contact_information.css('hrxml|PostalAddress',{hrxml:HRXML_NS}).first.css('hrxml|Region',{hrxml:HRXML_NS}).text rescue nil
      result.postal_code = contact_information.css('hrxml|PostalAddress',{hrxml:HRXML_NS}).first.css('hrxml|PostalCode',{hrxml:HRXML_NS}).text rescue nil
      result.country = contact_information.css('hrxml|PostalAddress',{hrxml:HRXML_NS}).first.css('hrxml|CountryCode',{hrxml:HRXML_NS}).text rescue nil

      result.home_phone = contact_information.css('hrxml|Telephone hrxml|FormattedNumber',{hrxml:HRXML_NS}).first.text rescue nil
      result.mobile_phone = contact_information.css('hrxml|Mobile hrxml|FormattedNumber',{hrxml:HRXML_NS}).first.text rescue nil

      result.website = contact_information.css('hrxml|InternetWebAddress',{hrxml:HRXML_NS}).first.text rescue nil
      result.email = contact_information.css('hrxml|InternetEmailAddress',{hrxml:HRXML_NS}).first.text rescue nil

      result
    end
  end
end
