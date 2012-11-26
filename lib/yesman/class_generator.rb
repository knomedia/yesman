require 'yesman/class_type'
require 'yesman/templater'
require 'yesman/file_util'
require 'yesman/config_proxy'

class ClassGenerator

  attr_reader :templates_path
  attr_reader :header_path
  attr_reader :class_path
  attr_reader :test_path
  attr_reader :main_path
  attr_reader :gtest_main_path

  def initialize
    @templates_path = "#{Dir.home}/.yesman/templates/"
    @header_path = create_path "header.cxx.erb"
    @class_path = create_path "class.cxx.erb"
    @test_path = create_path "test.cxx.erb"
    @main_path = create_path "main.cxx.erb"
    @gtest_main_path = create_path "gtest_main.cxx.erb"

    @templater = Templater.new
  end
  
  def create_class_files input
    c = create_class_type input
    files = [header_path, class_path, test_path]
    files.each do |path|
      file_contents = @templater.merge c, path
      FileUtil.write_to_file create_file_name( c, path ), file_contents
    end

  end

  def create_main
   c = create_class_type "Main"
   output_file_path = "#{params[:source]}/#{params[:project_name]}.#{params[:extension]}"
   FileUtil.write_to_file( output_file_path, ( @templater.merge c, main_path) )
  end

  def create_gtest_main
    c = create_class_type "GTestMain"
    file_contents = @templater.merge c, gtest_main_path
    FileUtil.write_to_file "#{params[:tests]}/#{params[:project_name]}Tests.#{params[:extension]}", file_contents
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
