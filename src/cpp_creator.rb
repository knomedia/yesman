class CppCreator
  attr_reader :source
  attr_reader :tests
  attr_reader :output

  def initialize(params = {})
    @source = params.fetch(:source){"src"}
    @tests = params.fetch(:tests){"tests"}
    @output = params.fetch(:output){"bin"}
  end


end



cp = CppCreator.new()

