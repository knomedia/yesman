require 'yesman/class_type'
require 'yesman/templater'
require 'yesman/file_util'
require 'yesman/config_proxy'
require 'yesman/logger'
require 'yesman/rake_gen_data'

class FileGenerator

  attr_reader :templates_path
  attr_reader :header_path
  attr_reader :class_path
  attr_reader :test_path
  attr_reader :main_path
  attr_reader :gtest_main_path
  attr_reader :rake_file_path

  def initialize
    @templates_path = "#{Dir.home}/.yesman/templates/"
    @header_path = create_path "header.cxx.erb"
    @class_path = create_path "class.cxx.erb"
    @test_path = create_path "test.cxx.erb"
    @main_path = create_path "main.cxx.erb"
    @gtest_main_path = create_path "gtest_main.cxx.erb"
    @rake_file_path = create_path "rakefile.erb"

    @templater = Templater.new
    @log = Logger.new
  end
  
  def create_class_files input
    c = create_class_type input
    files = [header_path, class_path, test_path]
    files.each do |path|
      file_contents = @templater.merge c, path
      file_name = create_file_name(c,path)
      FileUtil.write_to_file file_name, file_contents
      @log.log_creation "created", file_name
    end

  end

  def create_main
   c = create_class_type "Main"
   output_file_path = "#{params[:source]}/#{params[:project_name]}.#{params[:extension]}"
   FileUtil.write_to_file( output_file_path, ( @templater.merge c, main_path) )
   @log.log_creation "created", output_file_path
  end

  def create_gtest_main
    c = create_class_type "GTestMain"
    file_contents = @templater.merge c, gtest_main_path
    file_path = "#{params[:tests]}/#{params[:project_name]}Tests.#{params[:extension]}"
    FileUtil.write_to_file file_path , file_contents
    @log.log_creation "created", file_path
  end

  def create_build_file
    rake_data = RakeGenData.new
    file_contents = @templater.merge rake_data, rake_file_path
    file_path = "Rakefile"
    FileUtil.write_to_file file_path, file_contents
    @log.log_creation "created", file_path
  end

  private


  def create_file_name class_type, path
    file_name = ""
    case path
    when header_path
      file_name << "#{params[:source]}/" << class_type.class_name << ".h"
    when class_path
      file_name << "#{params[:source]}/" << class_type.class_name << ".#{params[:extension]}"
    when test_path
      file_name << "#{params[:tests]}/" << class_type.class_name << "Test.#{params[:extension]}"
    else
      file_name << "undefined"
    end
    file_name
  end

  def create_class_type input
    c = ClassType.new
    c.parse_from_string input
    c
  end

  def create_path filename
    "#{templates_path}#{filename}"
  end

  def params
    cp = ConfigProxy.new
    cp.params
  end
end
