module SovrenSaas
  class ResponseCode
    attr_accessor :code, :message, :file_type, :text, :text_code, :uses_remaining, :parser_version, :file_extension

    def self.parse(parse_resume_result)
      rc = self.new
      rc.code = parse_resume_result[:code]
      rc.message = parse_resume_result[:message]
      rc.file_type = parse_resume_result[:file_type]
      rc.text = parse_resume_result[:text]
      rc.text_code = parse_resume_result[:text_code]
      rc.uses_remaining = parse_resume_result[:uses_remaining]
      rc.parser_version = parse_resume_result[:parser_version]
      rc.file_extension = parse_resume_result[:file_extension]
      rc
    end

  end
end

