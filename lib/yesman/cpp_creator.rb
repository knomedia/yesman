require 'file_util'

class CppCreator
  attr_reader :source
  attr_reader :tests
  attr_reader :output
  attr_reader :project_name
  attr_reader :extension

  def initialize(params = {})
    set_defaults params
  end

  def create_project
    create_dirs
    create_source_main
    create_test_main
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
    FileUtil.ensure_path source
    FileUtil.ensure_path tests
    FileUtil.ensure_path output
  end

  def create_source_main
    FileUtil.ensure_file "#{source}/#{project_name}.#{extension}"
  end

  def create_test_main
    FileUtil.ensure_file "#{tests}/#{project_name}Tests.#{extension}"
  end

end
