module SovrenSaas
  class Competency
    attr_accessor :name, :months, :last_used_date

    def self.parse(competencies)
      return Array.new if competencies.nil?
      results = competencies.css('hrxml|Competency',{hrxml:HRXML_NS}).collect do |item|
        c = Competency.new
        c.name = item['name']
        c.months = item.css('hrxml|CompetencyEvidence hrxml|NumericValue',{hrxml:HRXML_NS}).text.to_i rescue nil
        c.last_used_date = Date.parse(item.css('hrxml|CompetencyEvidence',{hrxml:HRXML_NS}).first['lastUsed']) rescue nil
        c
      end
      results
    end

  end
end