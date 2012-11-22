require 'yesman/file_util'

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
    filename = "#{source}/#{project_name}.#{extension}"
    FileUtil.ensure_file filename
    FileUtil.write_to_file filename, get_source_main
  end

  def create_test_main
    filename = "#{tests}/#{project_name}Tests.#{extension}"
    FileUtil.ensure_file filename
    FileUtil.write_to_file filename, get_test_main
  end

  def get_test_main
    main = <<END
#include "gtest/gtest.h"

GTEST_API_ int main(int argc, char **argv) {
  testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}
END
  end

  def get_source_main
    main = <<END
#include <iostream>

int main() {
  std::cout << "What up world!" << std::endl;
  return 0;
}

END
  end
end
