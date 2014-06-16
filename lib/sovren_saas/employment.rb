module SovrenSaas
  class Employment
    attr_accessor :employer, :division, :city, :state, :country, :title, :description, :start_date, :end_date, :current_employer, :position

    def self.parse(employment_history)
      return Array.new if employment_history.nil?
      result = Array.new
      employment_history.css('hrxml|EmployerOrg', {hrxml:HRXML_NS}).each do |item|
        item.css('hrxml|PositionHistory', {hrxml:HRXML_NS}).each do |position|
          e = Employment.new
          e.employer = item.css('hrxml|EmployerOrgName', {hrxml:HRXML_NS}).text
          e.division = position.css('hrxml|OrganizationName', {hrxml:HRXML_NS}).text
          e.division = nil if e.employer == e.division
          e.city, e.state, e.country = item.css('hrxml|PositionLocation hrxml|Municipality, hrxml|PositionLocation hrxml|Region, hrxml|PositionLocation hrxml|CountryCode', {hrxml:HRXML_NS}).collect(&:text)
          e.title = position.css('hrxml|Title', {hrxml:HRXML_NS}).text
          e.description = position.css('hrxml|Description', {hrxml:HRXML_NS}).text
          e.start_date = Date.parse(position.css('hrxml|StartDate', {hrxml:HRXML_NS}).text) rescue nil
          e.current_employer = position['currentEmployer'] == "true"
          e.end_date = e.current_employer ? nil : (Date.parse(position.css('EndDate').text) rescue nil)
          e.position =  item.css('sov|Id', {sov:SOVREN_NS}).text rescue nil
          result.push(e)
        end
      end
      result
    end

    def current_employer?
      !current_employer.nil? && current_employer
    end

  end
end