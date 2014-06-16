require 'json'

module SovrenSaas
  class Resume
    attr_accessor :executive_summary, :objective, :contact_information, :education_history, :employment_history, :certifications, :competencies, :achievements, :associations, :languages, :military_history, :patent_history, :publication_history, :references, :non_xml_resume, :user_area, :warnings

    def self.parse(resume)
      parsed_resume = Nokogiri::XML.parse(resume)
      resume = self.new
      resume.executive_summary = parsed_resume.css('hrxml|ExecutiveSummary', {hrxml:HRXML_NS}).text
      resume.objective = parsed_resume.css('hrxml|Objective', {hrxml:HRXML_NS}).text
      resume.contact_information = ContactInformation.parse(parsed_resume.css('hrxml|ContactInfo', {hrxml:HRXML_NS}).first)
      resume.education_history = Education.parse(parsed_resume.css('hrxml|EducationHistory', {hrxml:HRXML_NS}).first)
      resume.employment_history = Employment.parse(parsed_resume.css('hrxml|EmploymentHistory', {hrxml:HRXML_NS}).first)
      resume.certifications = Certification.parse(parsed_resume.css('hrxml|LicensesAndCertifications', {hrxml:HRXML_NS}).first)
      resume.competencies = Competency.parse(parsed_resume.css('hrxml|Qualifications', {hrxml:HRXML_NS}).first)
      resume.achievements = Achievement.parse(parsed_resume.css('hrxml|Achievements', {hrxml:HRXML_NS}).first)
      resume.associations = Association.parse(parsed_resume.css('hrxml|Associations', {hrxml:HRXML_NS}).first)
      resume.languages = Language.parse(parsed_resume.css('hrxml|Languages', {hrxml:HRXML_NS}).first)
      resume.military_history = Military.parse(parsed_resume.css('hrxml|MilitaryHistory', {hrxml:HRXML_NS}).first)
      resume.patent_history = Patent.parse(parsed_resume.css('hrxml|PatentHistory', {hrxml:HRXML_NS}).first)
      resume.publication_history = Publication.parse(parsed_resume.css('hrxml|PublicationHistory', {hrxml:HRXML_NS}).first)
      resume.references = Reference.parse(parsed_resume.css('hrxml|References', {hrxml:HRXML_NS}).first)
      resume.non_xml_resume =  NonXMLResume.parse(parsed_resume.css('hrxml|NonXMLResume', {hrxml:HRXML_NS}).first)
      resume.user_area =   UserArea.parse(parsed_resume.css('hrxml|UserArea', {hrxml:HRXML_NS}))
      resume.warnings = Warning.parse(parsed_resume)
      resume
    end
  end
end