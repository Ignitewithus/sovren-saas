require 'spec_helper'

describe SovrenSaas::Client do
  Given(:sovren_client) { SovrenSaas::Client.new(endpoint: "http://services.resumeparsing.com/ResumeService.asmx?wsdl", account_id: "YOUR ACCTID", service_key: "YOUR SERVICE KEY") }

  context 'init' do
    Then { sovren_client.should_not be_nil }
  end

  context '.config' do
    Then { sovren_client.should respond_to :endpoint }
    Then { sovren_client.endpoint == "http://services.resumeparsing.com/ResumeService.asmx?wsdl" }
    Then { sovren_client.should respond_to :account_id }
    Then { sovren_client.account_id == "YOUR ACCTID" }
    Then { sovren_client.should respond_to :service_key }
    Then { sovren_client.service_key == "YOUR SERVICE KEY" }
  end

  describe 'parsing' do
    Given(:sovren_client) { SovrenSaas::Client.new(endpoint: "http://services.resumeparsing.com/ResumeService.asmx?wsdl", account_id: "YOUR ACCTID", service_key: "YOUR SERVICE KEY") }
    Given(:resume) { File.read(File.expand_path(File.dirname(__FILE__) + '/../support/ResumeSample.doc')) }

    context ".parse", vcr: {cassette_name: 'parsed_resume_new'} do
      When(:result) { sovren_client.parse(resume) }
      #Then {binding.pry}
      Then { result.class.should == SovrenSaas::Resume }
    end

  end

  describe 'get account info' do
    context ".get_account_info", vcr: {cassette_name: 'get_acct_info'} do
      Given(:sovren_client) { SovrenSaas::Client.new(endpoint: "http://services.resumeparsing.com/ResumeService.asmx?wsdl", account_id: "YOUR ACCTID", service_key: "YOUR SERVICE KEY") }
      When(:result) { sovren_client.get_account_info }
      Then { !result.blank? }
    end
  end


end