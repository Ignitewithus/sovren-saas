module SovrenSaas
  class Patent
    attr_accessor :title, :description, :inventor_name, :patent_id

    def self.parse(patents)
      return Array.new if patents.nil?
      result = patents.css('hrxml|Patent', {hrxml:HRXML_NS}).collect do |item|
        c = Patent.new
        c.title = item.css('hrxml|PatentTitle', {hrxml:HRXML_NS}).text
        c.description = item.css('hrxml|Description', {hrxml:HRXML_NS}).text
        c.inventor_name = item.css('hrxml|Inventors hrxml|InventorName', {hrxml:HRXML_NS}).first.text rescue nil
        c.patent_id = item.css('hrxml|PatentDetail hrxml|PatentMilestone hrxml|Id', {hrxml:HRXML_NS}).text
        c
      end
      result
    end
  
  end
end
