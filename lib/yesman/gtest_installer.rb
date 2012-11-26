require 'yesman/file_util'

class GTestInstaller

  attr_reader :gtest_local_repo_name
  attr_reader :gtest_dir
  attr_reader :gtest_path
  attr_reader :attr_names
  attr_reader :params 
  def initialize options
    @params = options
    @gtest_dir = "gtest"
    @gtest_path = "http://googletest.googlecode.com/svn/trunk/"
    @gtest_local_repo_name = "googletest-read-only"
    
  end

  def download_and_install
    print_start
    create_test_directories
    pull_source
    compile_source
    create_static_lib
    copy_needed_gtest_files
    clean_up_dirs
  end

private

  def print_start
    puts "Google Test Setup"
  end

  def pull_source
    puts "svn checkout of GTest source code..."
    `svn checkout #{gtest_path} #{repo_path}`
  end

  def compile_source
    puts "compiling GTest source code..."
    `g++ -I #{repo_path}/include/ -I #{repo_path}/ -c #{repo_path}/src/gtest-all.cc -o #{params[:tests]}/gtest/gtest-all.o`
  end

  def create_static_lib
    `ar -rv #{params[:tests]}/gtest/libgtest.a #{params[:tests]}/gtest/gtest-all.o`
  end
  

  def copy_needed_gtest_files
    puts "copying needed GTest files to tests dir"
    FileUtil.recursive_copy "#{repo_path}/include/gtest", "#{params[:tests]}/gtest/include"
  end

  def create_test_directories
    FileUtil.clear_directory "#{params[:tests]}/gtest"
    FileUtil.ensure_path "#{params[:tests]}/gtest/include"
  end

  def clean_up_dirs
    puts "cleaning up our trash"
    FileUtil.kill_directory gtest_dir
    FileUtil.kill_file "#{params[:tests]}/gtest/gtest-all.o"
    FileUtil.kill_directory "#{params[:tests]}/gtest/include/gtest/.svn"
    FileUtil.kill_directory "#{params[:tests]}/gtest/include/gtest/include/.svn"
  end

  def repo_path
   "#{gtest_dir}/#{gtest_local_repo_name}"
  end

end
