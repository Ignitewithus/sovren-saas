module SovrenSaas
  class Military
    attr_accessor :country_served, :branch, :rank_achieved, :recognition_achieved, :discharge_status, :start_date, :end_date

    def self.parse(military_history)
      return nil if military_history.nil?
      e = Military.new
      e.country_served = military_history.css('hrxml|CountryServed',{hrxml:HRXML_NS}).text
      e.branch = military_history.css('hrxml|ServiceDetail',{hrxml:HRXML_NS}).first['branch']
      e.rank_achieved = military_history.css('hrxml|ServiceDetail hrxml|RankAchieved hrxml|CurrentOrEndRank',{hrxml:HRXML_NS}).text
      e.recognition_achieved = military_history.css('hrxml|ServiceDetail hrxml|RecognitionAchieved',{hrxml:HRXML_NS}).text
      e.discharge_status = military_history.css('hrxml|ServiceDetail hrxml|DischargeStatus',{hrxml:HRXML_NS}).text
      e.start_date = Date.parse(military_history.css('hrxml|DatesOfService hrxml|StartDate hrxml|AnyDate',{hrxml:HRXML_NS}).text) rescue nil
      e.end_date = Date.parse(military_history.css('hrxml|DatesOfService hrxml|EndDate hrxml|AnyDate',{hrxml:HRXML_NS}).text) rescue nil
      e
    end

  end
end