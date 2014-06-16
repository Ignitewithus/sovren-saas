module SovrenSaas
  class Association
    attr_accessor :name, :role

    def self.parse(associations)
      return Array.new if associations.nil?
      result = associations.css('hrxml|Association',{hrxml:HRXML_NS}).collect do |item|
        c = Association.new
        c.name = item.css('hrxml|Name',{hrxml:HRXML_NS}).first.text
        c.role = item.css('hrxml|Role hrxml|Name',{hrxml:HRXML_NS}).text
        c
      end
      result
    end
  
  end
end