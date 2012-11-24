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
      copy_templates
      create_global_config
    end
  end

  private

  def copy_templates
    FileUtil.ensure_path "#{global_config_path}/templates"
    FileUtil.recursive_copy "lib/yesman/templates", "#{global_config_path}"
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
  
end
