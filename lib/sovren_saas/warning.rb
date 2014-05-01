module SovrenSaas
  class Warning
    CALCULATED = "CALCULATED"
    # according to Sovren, <= 9 is suspect and <= 8 isnt shown
    PROBABILITY_THRESHOLD = 12
    attr_accessor :section, :message, :position

    def self.parse(item)
      # pull user area warning spots
      user_area = item.css('UserArea')
      calculated = user_area.css('sov|ResumeUserArea sov|Sections sov|Section').collect do |s|
        if s['sectionType'].to_s == CALCULATED
          w = Warning.new
          w.section = s['sectionType'].to_s
          w.message = CALCULATED
          w
        end
      end

      # pull node specific errors - CompanyNameProbability
      comp_names = item.css('sov|CompanyNameProbability').collect do |c|
        if c.text.to_i <= PROBABILITY_THRESHOLD
          w = Warning.new
          w.section = "company_name"
          w.message = c.text
          w.position = c.parent.css('sov|Id').text
          w
        end
      end

      # pull node specific errors - PositionTitleProbability
      pos_names = item.css('sov|PositionTitleProbability').collect do |c|
        if c.text.to_i <= PROBABILITY_THRESHOLD
          w = Warning.new
          w.section = "position_title"
          w.message = c.text
          w.position = c.parent.css('sov|Id').text
          w
        end
      end

      result = calculated + comp_names + pos_names
      result = result.reject { |a| a.blank? }
      if result.any?
        result
      else
        nil
      end
    end
  end
end

