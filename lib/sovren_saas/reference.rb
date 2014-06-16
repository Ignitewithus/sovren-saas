module SovrenSaas
  class Reference
    attr_accessor :name, :title, :email, :phone_number

    def self.parse(references)
      return Array.new if references.nil?
      result = references.css('hrxml|Reference', {hrxml:HRXML_NS}).collect do |item|
        r = Reference.new
        r.name = item.css('hrxml|PersonName hrxml|FormattedName', {hrxml:HRXML_NS}).text
        r.title = item.css('hrxml|PositionTitle', {hrxml:HRXML_NS}).text
        r.email = item.css('hrxml|ContactMethod hrxml|InternetEmailAddress', {hrxml:HRXML_NS}).first.text rescue nil
        r.phone_number = item.css('hrxml|ContactMethod hrxml|Telephone hrxml|FormattedNumber', {hrxml:HRXML_NS}).first.text rescue nil
        r
      end
      result
    end
  end
end