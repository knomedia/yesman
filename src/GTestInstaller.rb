class GTestInstaller
  attr_reader :gtest_local_repo_name
  attr_reader :gtest_dir
  attr_reader :gtest_path
  attr_reader :attr_names
  
  def initialize()
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

  def print_start
    puts "********************************"
    puts "**     Google Test Setup      **"
    puts "********************************"
  end

  def pull_source
    puts "checkout (svn) of GTest source code..."
    `svn checkout #{gtest_path} #{repo_path}`
  end

  def compile_source
    puts "compiling GTest source code..."
    `g++ -I #{repo_path}/include/ -I #{repo_path}/ -c #{repo_path}/src/gtest-all.cc -o tests/gtest/gtest-all.o`
  end

  def create_static_lib
    puts "creating GTest static lib: 'libgtest.a'"
    `ar -rv tests/gtest/libgtest.a tests/gtest/gtest-all.o`
  end
  

  def copy_needed_gtest_files
    puts "copying needed GTest files to tests dir"
   `cp -r #{repo_path}/include/gtest tests/gtest/include`
  end

  def create_test_directories
    verify_dir 'tests'
    verify_dir 'tests/gtest'
    verify_dir 'tests/gtest/include'  
  end

  def clean_up_dirs
    puts "cleaning up our trash"
    `rm -rf #{gtest_dir}`
    `rm tests/gtest/gtest-all.o`
    `rm -rf tests/gtest/include/gtest/.svn` unless (!File.exists? 'tests/gtest/include/gtest/.svn')
  end

  def verify_dir dir
    `mkdir #{dir}` unless (File.exists? dir) && (File.directory? dir)
  end

  def repo_path
   "#{gtest_dir}/#{gtest_local_repo_name}"
  end

end


gti = GTestInstaller.new
gti.download_and_install
