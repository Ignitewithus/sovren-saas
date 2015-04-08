require 'json'

module SovrenSaas
  class JobOrder
    attr_accessor :response

    def self.parse(job_description)
      parsed_job_order = Nokogiri::XML.parse(job_description)
      job_order = self.new
      job_order.response = parsed_job_order
      job_order
    end
  end
end