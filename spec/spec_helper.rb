$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'enigma'
require 'fakefs/safe'

RSpec::Expectations.configuration.warn_about_potential_false_positives = false
