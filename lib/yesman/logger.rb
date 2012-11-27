require 'paint'

class Logger
  
  def log_emphasis heading, message
    puts "#{Paint[heading, :green]} #{Paint[message, :cyan]}"
  end

  def log_creation heading, file_path
    puts "... #{Paint[heading, :green]} #{file_path}"
  end

  def log_heading heading
    puts "#{Paint[heading, :yellow]}"
  end

  def log_message message
    puts "#{message}"
  end
  def line_break
    puts ""
  end
end
