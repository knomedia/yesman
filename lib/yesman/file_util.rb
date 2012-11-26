class FileUtil

  def self.ensure_file path
    dirs = self.determine_path path
    filename = dirs.pop
    self.create_directories dirs
    self.verify_or_make_file path
  end

  def self.ensure_path path
    dirs = self.determine_path path
    self.create_directories dirs
  end

  def self.clear_directory path
    self.kill_directory path
    self.ensure_path path 
  end

  def self.kill_directory path
    `rm -rf #{path}` unless (!File.exists? path) || (!File.directory? path)
  end

  def self.kill_file filename
    `rm #{filename}` unless !File.exists? filename
  end
    
  def self.recursive_copy from, to
    `cp -r #{from} #{to}`
  end

  def self.write_to_file filename, contents
    self.ensure_file filename
    File.open( filename, "w" ) { |f| f.write( contents ) }
  end
private

  def self.create_directories dirs
    next_path = ""
    exists = false
    dirs.each do |dirname|
      next_path << dirname << "/"
      exists = self.verify_or_make_dir next_path
    end
    exists
  end

  def self.determine_path path
    dirs = path.split("/")
    
  end

  def self.verify_or_make_dir dirname
    pre_existing = (File.exists? dirname) && (File.directory? dirname)
    `mkdir #{dirname}` unless pre_existing 
    pre_existing
  end

  def self.verify_or_make_file filename
    pre_existing = (File.exists? filename)
    unless pre_existing
      `touch #{filename}`
    end
    pre_existing
  end
    
end
