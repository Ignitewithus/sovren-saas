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
    context ".parse", vcr: {cassette_name: 'parsed_resume'} do
      When(:result) { sovren_client.parse(resume) }
      Then { result.class.should == SovrenSaas::Resume }
    end
  end

  describe 'get account info' do
    context ".get_account_info", vcr: {cassette_name: 'get_acct_info'} do
      Given(:sovren_client) { SovrenSaas::Client.new(endpoint: "https://services.resumeparsing.com/ResumeService.asmx?wsdl", account_id: "YOUR ACCTID", service_key: "YOUR SERVICE KEY") }
      When(:result) { sovren_client.get_account_info }
      Then { !result.blank? }
    end
  end

  describe 'parse a job request' do
    Given(:sovren_client) { SovrenSaas::Client.new(endpoint: "https://services.resumeparsing.com/ParsingService.asmx?wsdl", account_id: "YOUR ACCTID", service_key: "YOUR SERVICE KEY") }
    Given(:text) { File.read(File.expand_path(File.dirname(__FILE__) + '/../support/sample_job_desc.txt')) }
    context ".parse_job" , vcr: {cassette_name: 'job_parsed' } do
      When(:result) { sovren_client.parse_job_order(text) }
      Then { result.to_s.length > 0 }
    end
  end

end