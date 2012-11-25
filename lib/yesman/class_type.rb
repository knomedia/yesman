class ClassType
  attr_reader :class_name
  attr_reader :namespace
  attr_reader :super_class

  def initialize
    @class_name = nil
    @namespace = nil
    @super_class = nil
  end

  def parse_from_string input
    input = input.to_s
    st = input.split("<")
    st.each {|s| s.strip!}
    
    create_name_namespace st[0]
    
    if st[1] || st[1] != ""
      create_super st[1]
    else
      @super_class = nil
    end
  end


  private

  def create_name_namespace input
    if input.index( "::" ) 
      @namespace, @class_name = input.split "::"
    else
      @class_name = input
    end
  end

  def create_super input
   @super_class = nil
    if input 
      @super_class = ClassType.new
      @super_class.parse_from_string input
    end
  end


end
