module SovrenSaas
  class Employment
    attr_accessor :employer, :division, :city, :state, :country, :title, :description, :start_date, :end_date,
                  :current_employer, :position, :start_date_type, :end_date_type, :job_category, :department_code

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
          e.department_code = e.department_code(position)
          e.job_category = e.job_category(position)

          e.start_date = e.node_date(position, 'StartDate')
          e.start_date_type = e.node_date_type(position, 'StartDate')

          e.end_date = e.node_date(position, 'EndDate')
          e.end_date_type = e.node_date_type(position, 'EndDate')

          e.current_employer = position['currentEmployer'] == "true"
          e.position =  item.css('sov|Id', {sov:SOVREN_NS}).text rescue nil
          result.push(e)
        end
      end
      result
    end

    def current_employer?
      !current_employer.nil? && current_employer
    end

    def node_date(position, node)

      case node_date_type(position, node)
        when 'year'
          d = Date.parse("#{position.at_css("hrxml|#{node} hrxml|Year", {hrxml:HRXML_NS}).text}-01-01") rescue nil

        when 'year-month'
          d = Date.parse("#{position.at_css("hrxml|#{node} hrxml|YearMonth", {hrxml:HRXML_NS}).text}-01") rescue nil

        when 'anydate'
          d = Date.parse(position.at_css("hrxml|#{node}", {hrxml:HRXML_NS}).text) rescue nil
        else
          d = nil
      end

      d
    end

    def node_date_type(position,node)
      if position.at_css("hrxml|#{node} hrxml|Year", {hrxml:HRXML_NS})
        type = 'year'
      elsif position.at_css("hrxml|#{node} hrxml|YearMonth",{hrxml:HRXML_NS})
        type = 'year-month'
      elsif position.at_css("hrxml|#{node} hrxml|AnyDate",{hrxml:HRXML_NS})
        type = 'anydate'
      elsif position.at_css("hrxml|#{node} hrxml|StringDate",{hrxml:HRXML_NS})
        type = 'stringdate'
      else
        type = nil
      end

      type
    end

    def department_code(position)
      department_code = nil

      position.css('hrxml|JobCategory', {hrxml:HRXML_NS}).each do |category|
        if category.css('hrxml|TaxonomyName', {hrxml:HRXML_NS}).text == 'DEPARTMENT'
          department_code = category.css('hrxml|CategoryCode', {hrxml:HRXML_NS}).text
        end
      end

      department_code
    end

    def job_category(position)
      job_category = nil

      position.css('hrxml|JobCategory', {hrxml:HRXML_NS}).each do |category|
        if category.css('hrxml|TaxonomyName', {hrxml:HRXML_NS}).text == 'JOBCATEGORY'
          job_category = category.css('hrxml|CategoryCode', {hrxml:HRXML_NS}).text
        end
      end

      job_category
    end

  end
end