module SovrenSaas
  class Competency
    attr_accessor :name, :months, :last_used_date, :relates_to

    def self.parse(competencies)
      return Array.new if competencies.nil?
      results = competencies.css('hrxml|Competency',{hrxml:HRXML_NS}).collect do |item|
        c = Competency.new
        c.name = item['name']
        c.months = item.css('hrxml|CompetencyEvidence hrxml|NumericValue',{hrxml:HRXML_NS}).text.to_i rescue nil
        c.last_used_date = Date.parse(item.css('hrxml|CompetencyEvidence',{hrxml:HRXML_NS}).first['lastUsed']) rescue nil
        c.relates_to = c.detect_relations(item)
        c
      end
      results
    end

    def detect_relations(item)
      positions = item.css('hrxml|CompetencyEvidence', {hrxml: HRXML_NS}).attribute('typeDescription').text.split(';')

      return nil if positions.blank?

      positions[0] = positions[0].gsub('Found in ','')
      positions.map(&:strip)
    end

  end
end