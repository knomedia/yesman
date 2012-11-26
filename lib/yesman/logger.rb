class Logger
  
  def log_emphasis heading, message
    puts "#{heading} #{message}"
  end

  def log_creation heading, file_path
    puts "... #{heading} #{file_path}"
  end

  def log_heading heading
    puts "#{heading}"
  end

  def log_message message
    puts "#{message}"
  end
end
