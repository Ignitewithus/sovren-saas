module SovrenSaas
  class Education
    attr_accessor :school_name, :city, :state, :country, :degree_name, :degree_type, :major, :minor, :gpa, :gpa_out_of, :start_date, :end_date, :graduated
    
    def self.parse(education_history)
      return Array.new if education_history.nil?
      result = education_history.css('hrxml|SchoolOrInstitution', {hrxml:HRXML_NS}).collect do |item|
        e = Education.new
        e.school_name = item.css('hrxml|SchoolName', {hrxml:HRXML_NS}).text
        e.city, e.state, e.country = item.css('hrxml|PostalAddress hrxml|Municipality, hrxml|PostalAddress hrxml|Region, hrxml|PostalAddress hrxml|CountryCode', {hrxml:HRXML_NS}).collect(&:text)
        e.degree_type = item.css('hrxml|Degree', {hrxml:HRXML_NS}).first['degreeType']
        e.degree_name = item.css('hrxml|Degree hrxml|DegreeName',{hrxml:HRXML_NS}).text
        e.major = item.css('hrxml|DegreeMajor hrxml|Name', {hrxml:HRXML_NS}).text
        e.minor = item.css('hrxml|DegreeMinor hrxml|name', {hrxml:HRXML_NS}).text
        e.gpa = item.css('hrxml|EducationalMeasure hrxml|MeasureValue hrxml|StringValue', {hrxml:HRXML_NS}).text.to_f rescue nil
        e.gpa_out_of = item.css('hrxml|EducationalMeasure hrxml|HighestPossibleValue hrxml|StringValue', {hrxml:HRXML_NS}).text.to_f rescue nil
        e.start_date = Date.parse(item.css('hrxml|DatesOfAttendance hrxml|StartDate hrxml|AnyDate', {hrxml:HRXML_NS}).text) rescue nil
        e.end_date = Date.parse(item.css('hrxml|DatesOfAttendance hrxml|EndDate hrxml|AnyDate', {hrxml:HRXML_NS}).text) rescue nil
        e.graduated = item.css('hrxml|Degree hrxml|DegreeDate hrxml|AnyDate', {hrxml:HRXML_NS}).text != ""
        e
      end
      result
    end
  
    def graduated?
      !graduated.nil? && graduated
    end  

  end
end