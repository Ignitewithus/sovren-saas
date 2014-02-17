require 'bundler/setup'
require "sovren_saas/version"
require 'savon'
require 'httpclient'
require 'nokogiri'

module SovrenSaas
  class << self
    FIELDS = [:endpoint, :username, :password, :timeout, :hard_time_out_multiplier, :parser_configuration_params]
    attr_accessor(*FIELDS)

    def configure
      yield self
      true
    end
  end

  require_relative "sovren_saas/achievement"
  require_relative "sovren_saas/association"
  require_relative "sovren_saas/certification"
  require_relative "sovren_saas/client"
  require_relative "sovren_saas/competency"
  require_relative "sovren_saas/contact_information"
  require_relative "sovren_saas/education"
  require_relative "sovren_saas/employment"
  require_relative "sovren_saas/resume"
  require_relative "sovren_saas/language"
  require_relative "sovren_saas/military"
  require_relative "sovren_saas/patent"
  require_relative "sovren_saas/publication"
  require_relative "sovren_saas/reference"
  require_relative "sovren_saas/nonxmlresume"
  require_relative "sovren_saas/userarea"

end
