module SovrenSaas
  class Education
    attr_accessor :school_name, :city, :state, :country, :degree_name, :degree_type, :major,
                  :minor, :gpa, :gpa_out_of, :start_date, :start_date_type, :end_date, :end_date_type,
                  :graduated, :position, :school_type
    
    def self.parse(education_history)
      return Array.new if education_history.nil?
      result = education_history.css('hrxml|SchoolOrInstitution', {hrxml:HRXML_NS}).collect do |item|
        e = Education.new
        e.school_name = item.css('hrxml|SchoolName', {hrxml:HRXML_NS}).text
        e.school_type = item.attribute('schoolType').text
        e.city, e.state, e.country = item.css('hrxml|PostalAddress hrxml|Municipality, hrxml|PostalAddress hrxml|Region, hrxml|PostalAddress hrxml|CountryCode', {hrxml:HRXML_NS}).collect(&:text)
        e.degree_type = item.css('hrxml|Degree', {hrxml:HRXML_NS}).first['degreeType']
        e.degree_name = item.css('hrxml|Degree hrxml|DegreeName',{hrxml:HRXML_NS}).text
        e.major = item.css('hrxml|DegreeMajor hrxml|Name', {hrxml:HRXML_NS}).text
        e.minor = item.css('hrxml|DegreeMinor hrxml|name', {hrxml:HRXML_NS}).text
        e.gpa = item.css('hrxml|EducationalMeasure hrxml|MeasureValue hrxml|StringValue', {hrxml:HRXML_NS}).text.to_f rescue nil
        e.gpa_out_of = item.css('hrxml|EducationalMeasure hrxml|HighestPossibleValue hrxml|StringValue', {hrxml:HRXML_NS}).text.to_f rescue nil
        e.start_date = e.node_date(item, 'StartDate')
        e.start_date_type = e.node_date_type(item, 'StartDate')
        e.end_date = e.node_date(item, 'EndDate')
        e.end_date_type = e.node_date_type(item, 'EndDate')
        e.graduated = item.css('hrxml|Degree hrxml|DegreeDate hrxml|AnyDate', {hrxml:HRXML_NS}).text != ""
        e.position = item.css('sov|DegreeUserArea sov|Id', {sov:SOVREN_NS}).text
        e
      end
      result
    end
  
    def graduated?
      !graduated.nil? && graduated
    end

    def node_date(position, node)

      case node_date_type(position, node)
        when 'year'
          d = Date.parse("#{position.at_css("hrxml|DatesOfAttendance hrxml|#{node} hrxml|Year", {hrxml:HRXML_NS}).text}-01-01") rescue nil

        when 'year-month'
          d = Date.parse("#{position.at_css("hrxml|DatesOfAttendance hrxml|#{node} hrxml|YearMonth", {hrxml:HRXML_NS}).text}-01") rescue nil

        when 'anydate'
          d = Date.parse(position.at_css("hrxml|DatesOfAttendance hrxml|#{node} hrxml|AnyDate", {hrxml:HRXML_NS}).text) rescue nil
        else
          d = nil
      end

      d
    end

    def node_date_type(position,node)
      if position.at_css("hrxml|DatesOfAttendance hrxml|#{node} hrxml|Year", {hrxml:HRXML_NS})
        type = 'year'
      elsif position.at_css("hrxml|DatesOfAttendance hrxml|#{node} hrxml|YearMonth",{hrxml:HRXML_NS})
        type = 'year-month'
      elsif position.at_css("hrxml|DatesOfAttendance hrxml|#{node} hrxml|AnyDate",{hrxml:HRXML_NS})
        type = 'anydate'
      elsif position.at_css("hrxml|DatesOfAttendance hrxml|#{node} hrxml|StringDate",{hrxml:HRXML_NS})
        type = 'stringdate'
      else
        type = nil
      end

      type
    end
  end
end