require 'yesman/cpp_creator'
require 'yesman/file_util'
require 'yesman/gtest_installer'
require 'yesman/logger'

class Yesman
  attr_reader :params

  def initialize options = {}
    create_defaults options
    @cp = ConfigProxy.new
    @log = Logger.new
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
    @log.line_break
    @log.log_heading "Creating initial directories and files"
    FileUtil.ensure_path params[:project_name]
    Dir.chdir( params[:project_name] )
    create_all
  end

  def create_all
    @cp.create_config params
    p = CppCreator.new params
    p.create_project
    @log.log_message "Initial project files created"
    @log.line_break
    g = GTestInstaller.new params
    g.download_and_install
    @log.line_break
    @log.log_emphasis "Setup complete!", "You are clear for take off."
  end

end
