module Sovren
  class UserArea
    attr_accessor :language, :country, :description, :months_worked, :best_fit, :fit_percentage, :parse_time

    def self.parse(user_area)
      return Array.new if user_area.nil?
      result = user_area.css('sov|ResumeUserArea').collect do |item|
        r = UserArea.new
        r.language = item.css('sov|Culture sov|Language').text rescue nil
        r.country = item.css('sov|Culture sov|Country').text rescue nil
        r.description = item.css('sov|ExperienceSummary sov|Description').text rescue nil
        r.months_worked = item.css('sov|ExperienceSummary sov|MonthsOfWorkExperience').text rescue nil
        r.fit_percentage = item.css('sov|ExperienceSummary sov|BestFitTaxonomies sov|BestFitTaxonomy').first.attribute('percentOfOverall').text rescue nil
        r.best_fit = item.css('sov|ExperienceSummary sov|BestFitTaxonomies sov|BestFitTaxonomy').first.attribute('name').text rescue nil
        r.parse_time = item.css('sov|ParseTime').text rescue nil
        r
      end
      result
    end
  end
end