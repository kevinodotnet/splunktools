require 'active_support/all'
require 'json'
require 'time'

class SplunkLogParser

  def self.parse_line(line)
    details = JSON.parse(line)
    return details.with_indifferent_access unless details['result']
    details[:time] = DateTime.parse(details['result']['_time']) if details['result']['_time']
    details[:text] = details['result']['_raw'] if details['result']['_raw']
    details.with_indifferent_access
  end

  def self.scan_json_file(file)
    linenum = 1
    File.open(file, "r").each_line do |line|
      begin
        yield(parse_line(line))
        linenum += 1
      rescue => e
        puts "Error on line# #{linenum}: #{e}"
        raise e
      end
    end
  end

  def self.read_json_file(file)
    linenum = 1
    entries = []
    File.open(file, "r").each_line do |line|
      begin
        entries << parse_line(line)
        linenum += 1
      rescue => e
        puts "Error on line# #{linenum}: #{e}"
        raise e
      end
    end
    entries
  end

end
