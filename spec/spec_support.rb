$:.unshift(File.join(File.dirname(__FILE__), '../lib/'))

gem "minitest"

require "minitest/spec"
require "odyssey"

ODYSSEY_ITEST_DIRECTORY = File.expand_path(File.join(File.dirname(__FILE__), "../tmp"))
ODYSSEY_LIB_DIRECTORY = File.expand_path(File.join(File.dirname(__FILE__), "../lib"))

class OdysseyIntegrationTest
  def initialize
    # clear that directory...
    Dir["#{ODYSSEY_ITEST_DIRECTORY}/*"].each do |path|
      File.delete path
    end
  end

  def file name, content
    File.open(File.join(ODYSSEY_ITEST_DIRECTORY, name), "w") do |f|
      f.puts content
    end
  end

  def run file_to_start
    `cd #{ODYSSEY_ITEST_DIRECTORY}; ruby -I #{ODYSSEY_LIB_DIRECTORY} #{file_to_start}`
  end
end



require "minitest/autorun"
