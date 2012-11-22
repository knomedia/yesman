require 'rubygems'
require 'mixlib/cli'

class CliParser
  include Mixlib::CLI

  option :source,
    :short => "-s SOURCE",
    :long => "--source SOURCE",
    :default => "src",
    :description => "The name of the source directory to build"
    
  option :tests,
    :short => "-t TESTS",
    :long => "--tests TESTS",
    :default => "tests",
    :description => "The name of the tests directory to build"

  option :output,
    :short => "-o OUTPUT",
    :long => "--output OUTPUT",
    :default => "bin",
    :description => "The name of the output directory to build"
  
  option :project_name,
    :short => "-n NAME",
    :long => "--name NAME",
    :default => "Project",
    :description =>"The name of the project to build"

  def run(argv=ARGV)
    parse_options(argv)
  end
end
