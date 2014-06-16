module SovrenSaas
  class Certification
    attr_accessor :name, :description, :effective_date

    def self.parse(certifications)
      return Array.new if certifications.nil?
      result = certifications.css('hrxml|LicenseOrCertification', {hrxml:HRXML_NS}).collect do |item|
        c = Certification.new
        c.name = item.css('hrxml|Name', {hrxml:HRXML_NS}).text
        c.description = item.css('hrxml|Description', {hrxml:HRXML_NS}).text
        c.effective_date = Date.parse(item.css('hrxml|EffectiveDate hrxml|FirstIssuedDate hrxml|AnyDate', {hrxml:HRXML_NS}).text) rescue nil
        c
      end
      result
    end
  
  end
end