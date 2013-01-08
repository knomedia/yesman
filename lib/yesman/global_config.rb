require 'yesman/version'

class GlobalConfig
  attr_reader :pre_existing
  attr_reader :global_config_path

  def initialize
    @pre_existing = false
    @global_config_path =  "#{Dir.home}/.yesman"
  end

  def load
    ensure_config_dir

    if !pre_existing
      puts "Copying file templates to #{global_config_path}" 
      copy_all
    elsif old_version?
      FileUtil.clear_directory global_config_path
      copy_all
    end
  end

  private

  def copy_all
    copy_templates
    create_version_file
    create_global_config
  end


  def copy_templates
    FileUtil.ensure_path "#{global_config_path}/templates"
    templates = File.join(File.dirname(File.expand_path(__FILE__)), 'templates');
    FileUtil.recursive_copy(templates, global_config_path)
  end

  def create_version_file
    file_path = "#{global_config_path}/version"
    FileUtil.ensure_file file_path
    FileUtil.write_to_file file_path, Yesman::VERSION
  end

  def create_global_config
    params = {};
    params[:source] = "src"
    params[:output] = "bin"
    params[:tests] = "tests"
    params[:ext] = "cpp"
    #TODO Write these to a config file in global_config_path
    #I'm not sold that you need them at this point
  end
  
  def ensure_config_dir
    @pre_existing = FileUtil.ensure_path global_config_path
  end

  def old_version?
    old = false;
    version_path = "#{global_config_path}/version"
    if !File.exists? version_path
      old = true
    else
      contents = File.read( version_path ).to_i
      puts "Current global yesman version: #{contents}"
      if contents != Yesman::VERSION
        old = true
      end
    end
    old
  end
  
end
