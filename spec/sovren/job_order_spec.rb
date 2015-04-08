require 'spec_helper'

describe SovrenSaas::JobOrder do
  Given(:job_order) { SovrenSaas::JobOrder.new }

  Then { job_order.should respond_to :response }


  context '.parse' do
    use_natural_assertions
    Given(:raw_xml) { File.read(File.expand_path(File.dirname(__FILE__) + '/../support/job_order_response.xml')) }

    When(:result) { SovrenSaas::JobOrder.parse(raw_xml) }

    Then { result.response.to_s.length == 3371}

  end
end