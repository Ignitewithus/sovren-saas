module SovrenSaas
  class Achievement
    attr_accessor :description

    def self.parse(achievements)
      return Array.new if achievements.nil?
      result = achievements.css('hrxml|Achievement',{hrxml:HRXML_NS}).collect do |item|
        c = Achievement.new
        c.description = item.css('hrxml|Description',{hrxml:HRXML_NS}).text
        c
      end
      result
    end
  
  end
end