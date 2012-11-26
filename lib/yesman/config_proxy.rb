require 'yaml'

class ConfigProxy 
  
  attr_reader :params
  attr_reader :config_path

  def initialize
    @params = nil
    @config_path = ".yesman/config"
  end

  def create_config params
    verify_config_exists
    File.open( config_path, "w" ) do |file| 
      file.write params.to_yaml
    end
    @params = params;
  end

  def load_config
    verify_config_exists
    @params = YAML::load_file config_path
  end

  def params 
    if @params == nil
      load_config
    end
    @params
  end

  def config_exists?
    return File.exists? config_path
  end

  private
  def verify_config_exists
    FileUtil.ensure_file config_path
  end
  
end
