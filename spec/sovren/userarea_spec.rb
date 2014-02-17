require 'spec_helper'

describe SovrenSaas::UserArea do
  use_natural_assertions

  When(:user_area) { SovrenSaas::UserArea.new }

  Then { user_area.should respond_to :language }
  Then { user_area.should respond_to :country }
  Then { user_area.should respond_to :description }
  Then { user_area.should respond_to :months_worked }
  Then { user_area.should respond_to :best_fit }
  Then { user_area.should respond_to :fit_percentage }
  Then { user_area.should respond_to :parse_time }

  context ".parse" do
    context "a full resume" do
      Given(:raw_xml) { File.read(File.expand_path(File.dirname(__FILE__) + '/../support/user_area.xml')) }
      Given(:xml) { Nokogiri::XML.parse(raw_xml) }
      When(:result) { SovrenSaas::UserArea.parse(xml) }
      # UserArea may not be populated, but at a minimum we should have a length 1 object
      Then { result.length == 1 }

    end
  end

  context "no user area" do
    When(:result) { SovrenSaas::UserArea.parse(nil) }
    Then { result == Array.new }
  end
end
