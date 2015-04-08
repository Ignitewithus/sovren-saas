module SovrenSaas
  class Client
    attr_reader :endpoint, :username, :password, :timeout, :hard_time_out_multiplier, :parser_configuration_params, :account_id, :service_key

    #Initialize the client class that will be used for all sovren_saas requests.
    #
    # @param [Hash] options
    # @option options String :endpoint The url that the web service is located at
    # @option options String :account_id The account ID for the Sovren SaaS service, given to you by Sovren
    # @option options String :service_key The service key for the Sovren SaaS service, given to you by Sovren
    # @option options Integer :parser_configuration_params The parser configuration params, used to tweak the output of the parser

    def initialize(options={})
      @account_id = options[:account_id]
      @service_key = options[:service_key]
      @configuration = options[:parser_configuration_params] || "_100000_0_00000010_0000000110101100_1_0000000000000111111102000000000010000100000000000000"
      @endpoint = options[:endpoint] || "https://services.resumeparsing.com/ResumeService.asmx?wsdl"
      @https_endpoint = options[:https_endpoint] || "https://services.resumeparsing.com/ResumeService.asmx"
      @enable_log = options[:enable_log] || false
    end

    # def init_job_parser(options={})
    #   @account_id = options[:account_id]
    #   @service_key = options[:service_key]
    #   @configuration = options[:parser_configuration_params] || "_100000_0_00000010_0000000110101100_1_0000000000000111111102000000000010000100000000000000"
    #   @endpoint = options[:endpoint] || "https://services.resumeparsing.com/ResumeService.asmx?wsdl"
    #   @https_endpoint = options[:https_endpoint] || "https://services.resumeparsing.com/ParsingService.asmx"
    #   @enable_log = options[:enable_log] || false
    # end


    def connection
      # the Sovren wsdl references the http version of all the calls, so make sure we point to the https version
      Savon.client(wsdl: @endpoint, log: @enable_log, endpoint: @https_endpoint)
    end

    def parse(file)
      result = connection.call(:parse_resume) do |c|
        c.message({"request" => {
                      "AccountId" => @account_id,
                      "ServiceKey" => @service_key,
                      "FileBytes" => Base64.encode64(file),
                      "Configuration" => @configuration
                  }
                  })
      end
      Resume.parse(result.body[:parse_resume_response][:parse_resume_result][:xml])
    end

    def parse_hrxml(hrxml)
      Resume.parse(hrxml)
    end


    def parse_job_order(job_text)
      result = connection.call(:parse_job_order) do |c|
        c.message({"request" => {
                      "AccountId" => @account_id,
                      "ServiceKey" => @service_key,
                      "FileText" => job_text,
                      "Configuration" => @configuration
                  }
                  })
      end
      result
    end


    def get_account_info
      result = connection.call(:get_account_info) do |c|
        c.message({"request" => {
                      "AccountId" => @account_id,
                      "ServiceKey" => @service_key
                  }
                  })
      end
      result
    end


  end
end