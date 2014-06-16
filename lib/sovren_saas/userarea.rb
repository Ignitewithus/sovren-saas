module SovrenSaas
  class UserArea
    attr_accessor :language, :country, :description, :months_worked, :best_fit, :fit_percentage, :parse_time

    def self.parse(user_area)
      return Array.new if user_area.nil?
      result = user_area.css('sov|ResumeUserArea', {sov:SOVREN_NS}).collect do |item|
        r = UserArea.new
        r.language = item.css('sov|Culture sov|Language', {sov:SOVREN_NS}).text rescue nil
        r.country = item.css('sov|Culture sov|Country', {sov:SOVREN_NS}).text rescue nil
        r.description = item.css('sov|ExperienceSummary sov|Description', {sov:SOVREN_NS}).text rescue nil
        r.months_worked = item.css('sov|ExperienceSummary sov|MonthsOfWorkExperience', {sov:SOVREN_NS}).text rescue nil
        r.fit_percentage = item.css('sov|ExperienceSummary sov|BestFitTaxonomies sov|BestFitTaxonomy', {sov:SOVREN_NS}).first.attribute('percentOfOverall').text rescue nil
        r.best_fit = item.css('sov|ExperienceSummary sov|BestFitTaxonomies sov|BestFitTaxonomy', {sov:SOVREN_NS}).first.attribute('name').text rescue nil
        r.parse_time = item.css('sov|ParseTime', {sov:SOVREN_NS}).text rescue nil
        r
      end
      result
    end
  end
end