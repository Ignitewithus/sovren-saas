require 'spec_helper'

describe Sovren::NonXMLResume do
  use_natural_assertions

  When(:non_xml_resume) { Sovren::NonXMLResume.new }

  Then { non_xml_resume.should respond_to :text_resume }


  context ".parse" do
    context "a full resume" do
      Given(:raw_xml) { File.read(File.expand_path(File.dirname(__FILE__) + '/../support/non_xml_resume.xml')) }
      Given(:xml) { Nokogiri::XML.parse(raw_xml) }
      When(:result) { Sovren::NonXMLResume.parse(xml) }
      Then { result.length == 1 }

    end
  end

  context "no text resume" do
    When(:result) { Sovren::NonXMLResume.parse(nil) }
    Then { result == Array.new }
  end
end


