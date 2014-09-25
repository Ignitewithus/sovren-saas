module SovrenSaas
  class SovrenXml
    attr_accessor :content

    def self.parse(xml_document)
      return nil if xml_document.blank?

      result = SovrenXml.new
      result.content = xml_document
      result
    end

  end
end
