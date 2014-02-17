require 'spec_helper'

describe Sovren::Client do
  # Given(:sovren_client) { Sovren::Client.new(endpoint: "foo1", username: "foo2", password: "foo3") }
  Given(:sovren_client) { Sovren::Client.new(endpoint: "http://services.resumeparsing.com/ResumeService.asmx?wsdl", account_id: "26790859", service_key: "3bcOMJHxKRMZkf1lxC7MzT7QlE8LoVDiCrTmKaKM") }

  context 'init' do
    Then { sovren_client.should_not be_nil }
  end

  #context '.config' do
  # Then { sovren_client.should respond_to :endpoint }
  # Then { sovren_client.endpoint == "foo1" }
  # Then { sovren_client.should respond_to :username }
  # Then { sovren_client.username == "foo2" }
  # Then { sovren_client.should respond_to :password }
  # Then { sovren_client.password == "foo3" }
  #end

  describe 'parsing' do
    Given(:sovren_client) { Sovren::Client.new(endpoint: "http://services.resumeparsing.com/ResumeService.asmx?wsdl", account_id: "26790859", service_key: "3bcOMJHxKRMZkf1lxC7MzT7QlE8LoVDiCrTmKaKM") }
    Given(:resume) { File.read(File.expand_path(File.dirname(__FILE__) + '/../support/ResumeSample.doc')) }

    context ".parse", vcr: {cassette_name: 'parsed_resume_new'}  do
      When(:result) { sovren_client.parse(resume) }
      Then { result.class.should == Sovren::Resume }
    end

  end

  describe 'get account info' do
    Given(:sovren_client) { Sovren::Client.new(endpoint: "http://services.resumeparsing.com/ResumeService.asmx?wsdl", account_id: "26790859", service_key: "3bcOMJHxKRMZkf1lxC7MzT7QlE8LoVDiCrTmKaKM") }
    When(:result) { sovren_client.get_account_info }
    Then {}
  end


end