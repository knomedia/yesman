require 'yesman/config_proxy'
require 'erb'

class RakeGenData

  attr_reader :source_dir
  attr_reader :test_dir
  attr_reader :output_dir
  attr_reader :project_name
  attr_reader :extension

  def initialize(args = {})
    params = ConfigProxy.new.params
    @source_dir = params[:source]
    @test_dir = params[:tests]
    @output_dir = params[:output]
    @project_name = params[:project_name]
    @extension = params[:extension]
  end


  def get_binding
    binding
  end


end
