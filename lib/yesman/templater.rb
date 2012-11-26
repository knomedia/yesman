require 'erb'

class Templater
  
  def merge class_type, template_path
    @class_type = class_type
    @template_path = template_path

    load_template
    apply_class_to_template
    @output
  end

  def load_template
    @loaded_template = ERB.new File.read( @template_path )
  end

  def apply_class_to_template
    @output = @loaded_template.result( @class_type.get_binding ) 
  end
  
end
