$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'bloom_remit_client'
require 'pathname'
require 'yaml'
require 'pry'
require 'faker'
require "virtus/matchers/rspec"

SPEC_DIR = Pathname.new(File.dirname(__FILE__))

Dir[SPEC_DIR.join("support", "**", "*.rb")].each {|f| require f}

CONFIG = YAML.load_file(SPEC_DIR.join("config.yml")).with_indifferent_access
