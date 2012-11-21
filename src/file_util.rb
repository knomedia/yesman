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
    
private

  def self.create_directories dirs
    next_path = ""
    dirs.each do |dirname|
      next_path << dirname << "/"
      self.verify_or_make_dir next_path
    end
  end

  def self.determine_path path
    dirs = path.split("/")
    
  end

  def self.verify_or_make_dir dirname
    `mkdir #{dirname}` unless (File.exists? dirname) && (File.directory? dirname) 
  end

  def self.verify_or_make_file filename
    `touch #{filename}` unless (File.exists? filename)
  end
    
end
