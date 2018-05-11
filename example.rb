#!/usr/bin/env ruby

load 'splunk_log_parser.rb'
require 'pry'

SplunkLogParser.scan_json_file('/path/to/splunk/json/download.json') do |entry|
  # do what you want with each result entry
  # format of entry depends on what your search was
  binding.pry
end

