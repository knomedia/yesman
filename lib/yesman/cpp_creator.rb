require 'yesman/file_util'
require 'yesman/logger'
require 'yesman/file_generator'

class CppCreator
  attr_reader :source
  attr_reader :tests
  attr_reader :output
  attr_reader :project_name
  attr_reader :extension

  def initialize(params = {})
    set_defaults params
    @gen = FileGenerator.new
    @log = Logger.new
  end

  def create_project
    create_dirs
    create_source_main
    create_test_main
    create_build_file
  end

private 

  def set_defaults params
    @source = params.fetch(:source){"src"}
    @tests = params.fetch(:tests){"tests"}
    @output = params.fetch(:output){"bin"}
    @project_name = params.fetch(:project_name){"Project"}
    @extension = params.fetch(:extension){"ccp"}
  end

  def create_dirs
    paths = [source, tests, output]
    paths.each do |path|
      FileUtil.ensure_path path
      @log.log_creation "created", "#{path}/"
    end
  end

  def create_source_main
    @gen.create_main    
  end

  def create_test_main
    @gen.create_gtest_main
  end

  def create_build_file
    @gen.create_build_file
  end
end
