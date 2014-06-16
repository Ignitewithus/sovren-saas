module SovrenSaas
  class Publication
    attr_accessor :type, :title, :role, :publication_date, :journal_or_serial_name, :volume, :issue, :page_number, :abstract, :copyright_date, :copyright_text, :edition, :isbn, :publisher_name, :publisher_location, :event_name, :conference_date, :conference_location, :comments, :number_of_pages

    def self.parse(publications)
      return Array.new if publications.nil?
      result = publications.css('hrxml|Article,hrxml|Book,hrxml|ConferencePaper,hrxml|OtherPublication', {hrxml:HRXML_NS}).collect do |item|
        c = Publication.new
        c.type = item.name == "OtherPublication" ? item['type'] : item.name
        c.title = item.css('hrxml|Title', {hrxml:HRXML_NS}).text
        c.role = item.css('hrxml|Name', {hrxml:HRXML_NS}).first['role'] rescue nil
        c.publication_date = item.css('hrxml|PublicationDate', {hrxml:HRXML_NS}).css('hrxml|YearMonth, hrxml|Year', {hrxml:HRXML_NS}).first.text rescue nil
        c.journal_or_serial_name = item.css('hrxml|JournalOrSerialName', {hrxml:HRXML_NS}).text
        c.volume = item.css('hrxml|Volume', {hrxml:HRXML_NS}).text
        c.issue = item.css('hrxml|Issue', {hrxml:HRXML_NS}).text
        c.page_number = item.css('hrxml|PageNumber', {hrxml:HRXML_NS}).text
        c.abstract = item.css('hrxml|Abstract', {hrxml:HRXML_NS}).text
        c.copyright_date = item.css('hrxml|Copyright hrxml|CopyrightDates hrxml|OriginalDate hrxml|Year, hrxml|Copyright hrxml|CopyrightDates hrxml|OriginalDate hrxml|YearMonth', {hrxml:HRXML_NS}).first.text rescue nil
        c.copyright_text = item.css('hrxml|Copyright hrxml|CopyrightText', {hrxml:HRXML_NS}).first.text rescue nil
        c.edition = item.css('hrxml|Edition', {hrxml:HRXML_NS}).text
        c.isbn = item.css('hrxml|ISBN', {hrxml:HRXML_NS}).text
        c.publisher_name = item.css('hrxml|PublisherName', {hrxml:HRXML_NS}).text
        c.publisher_location = item.css('hrxml|PublisherLocation', {hrxml:HRXML_NS}).text
        c.event_name = item.css('hrxml|EventName', {hrxml:HRXML_NS}).text
        c.conference_date = Date.parse(item.css('hrxml|ConferenceDate hrxml|AnyDate', {hrxml:HRXML_NS}).text) rescue nil
        c.conference_location = item.css('hrxml|ConferenceLocation', {hrxml:HRXML_NS}).text
        c.comments = item.css('hrxml|Comments', {hrxml:HRXML_NS}).text
        c.number_of_pages = item.css('hrxml|NumberOfPages', {hrxml:HRXML_NS}).text.to_i rescue nil
        c
      end
      result
    end
  
  end
end
