require 'spec_helper'

describe SovrenSaas::NonXMLResume do
  use_natural_assertions

  When(:non_xml_resume) { SovrenSaas::NonXMLResume.new }

  Then { non_xml_resume.should respond_to :text_resume }


  context ".parse" do
    context "a full resume" do
      Given(:raw_xml) { File.read(File.expand_path(File.dirname(__FILE__) + '/../support/non_xml_resume.xml')) }
      Given(:xml) { Nokogiri::XML.parse(raw_xml) }
      When(:result) { SovrenSaas::NonXMLResume.parse(xml) }
      Then { !result.text_resume.length.blank? }

    end
  end

  context "no text resume" do
    When(:result) { SovrenSaas::NonXMLResume.parse(nil) }
    Then { result == nil }
  end
end