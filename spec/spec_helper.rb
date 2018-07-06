require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new [
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

SimpleCov.start

require 'jobz'
require 'minitest'
require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/setup'
