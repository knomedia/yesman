require 'yesman/cpp_creator'
require 'yesman/file_util'
require 'yesman/gtest_installer'

class Yesman
  attr_reader :params

  def initialize options = {}
    create_defaults options
    @cp = ConfigProxy.new
    init
  end

  def create_defaults hash
    @params = {}
    @params[:project_name] = hash.fetch(:project_name){"Project"}
    @params[:extension] = hash.fetch(:extension){"cpp"}
    @params[:source] = hash.fetch(:source){"src"}
    @params[:tests] = hash.fetch(:tests){"tests"}
    @params[:output] = hash.fetch(:output){"bin"}
  end

  def init
    FileUtil.ensure_path params[:project_name]
    Dir.chdir( params[:project_name] )
    create_all
  end

  def create_all
    @cp.create_config params
    p = CppCreator.new params
    p.create_project
    puts "Project directories created"

    g = GTestInstaller.new params
    g.download_and_install

  end

end
