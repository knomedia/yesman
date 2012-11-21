class GTestInstaller
  attr_reader :gtest_local_repo_name
  attr_reader :gtest_dir
  attr_reader :gtest_path
  attr_reader :attr_names
  

  def initialize()
    @gtest_dir = "gtest"
    @gtest_path = "http://googletest.googlecode.com/svn/trunk/"
    @gtest_local_repo_name = "googletest-read-only"
    
    do_all
  end

  def do_all
    create_test_directories
    pull_source
    compile_source
    create_static_lib
    copy_needed_gtest_files
    clean_up_dirs
  end

  def pull_source
    puts "Pulling Google Test source code..."
    `svn checkout #{gtest_path} #{gtest_dir}/#{gtest_local_repo_name}`
  end

  def compile_source
    puts "Compiling Google Test source code..."
    `g++ -I #{gtest_dir}/#{gtest_local_repo_name}/include/ -I #{gtest_dir}/#{gtest_local_repo_name}/ -c #{gtest_dir}/#{gtest_local_repo_name}/src/gtest-all.cc -o tests/gtest/gtest-all.o`
  end

  def create_static_lib
    puts "Creating Google Test static lib: 'libgtest.a'"
    `ar -rv tests/gtest/libgtest.a tests/gtest/gtest-all.o`
  end
  

  def copy_needed_gtest_files
    puts "Copying needed GTest files to tests dir..."
   `cp -r #{gtest_dir}/#{gtest_local_repo_name}/include tests/gtest/`
  end

  def create_test_directories
    verify_dir 'tests'
    verify_dir 'tests/gtest'
    verify_dir 'tests/gtest/include'  
  end

  def clean_up_dirs
    puts "Cleaning up our trash..."
    `rm -rf #{gtest_dir}`
    `rm tests/gtest/gtest-all.o`
  end

  def verify_dir dir
    `mkdir #{dir}` unless (File.exists? dir) && (File.directory? dir)
  end


end


gti = GTestInstaller.new

