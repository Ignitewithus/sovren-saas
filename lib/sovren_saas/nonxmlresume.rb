module SovrenSaas
  class NonXMLResume
    attr_accessor :text_resume

    def self.parse(non_xml_resume)
      return nil if non_xml_resume.nil?
      r = NonXMLResume.new
      r.text_resume = non_xml_resume.css('hrxml|TextResume', {hrxml:HRXML_NS}).text rescue nil
      r
    end
  end
end