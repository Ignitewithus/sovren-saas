module SovrenSaas
  class Language
    attr_accessor :language_code, :read, :write, :speak

    def self.parse(languages)
      return Array.new if languages.nil?
      result = languages.css('hrxml|Language',{hrxml:HRXML_NS}).collect do |item|
        c = Language.new
        c.language_code = item.css('hrxml|LanguageCode',{hrxml:HRXML_NS}).text
        c.read = item.css('hrxml|Read',{hrxml:HRXML_NS}).text == "true" rescue nil
        c.write = item.css('hrxml|Write',{hrxml:HRXML_NS}).text == "true" rescue nil
        c.speak = item.css('hrxml|Speak',{hrxml:HRXML_NS}).text == "true" rescue nil
        c
      end
      result
    end

    def read?
      !read.nil? && read
    end
  
    def write?
      !write.nil? && write
    end
  
    def speak?
      !speak.nil? && speak
    end
  
  end
end