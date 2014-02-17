require 'spec_helper'

describe SovrenSaas::Competency do
  use_natural_assertions

  context ".parse" do
    context "a full resume" do
      Given(:raw_xml) { File.read(File.expand_path(File.dirname(__FILE__) + '/../support/competencies.xml')) }
      Given(:xml) { Nokogiri::XML.parse(raw_xml) }

      When(:result) { SovrenSaas::Competency.parse(xml) }

      Then { result.length == 50 }
      Then { result.first.name == "MARKETING" }
      Then { result.first.months == 158 }
      Then { result.first.last_used_date == Date.new(2013,4,29) }
    end

    context "no competencies" do
      When(:result) { SovrenSaas::Competency.parse(nil) }

      Then { result == Array.new }
    end
  end

end