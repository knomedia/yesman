require 'helper'

def create_class string
  ex = ClassType.new
  ex.parse_from_string string
  ex
end
describe ClassType do

  it "handles namespaced inheritance for both itself and parent" do
    ct = ClassType.new
    ct.parse_from_string "jsk::Testing < std::Parent"
    ct.class_name.should eql "Testing"
    ct.namespace.should eql "jsk"
    ct.super_class.class_name.should eq "Parent"
    ct.super_class.namespace.should eq "std"
  end

  it "should handle namespaced non inheritance" do
    ct = create_class "jsk::Testing"
    ct.class_name.should eq "Testing"
    ct.namespace.should eq "jsk"
    ct.super_class.should eq nil
  end

  it "should handle single class name with ns inheritance" do
    cb = create_class "SingleTesting < jsk::Parent"
    cb.class_name.should eq "SingleTesting"
    cb.namespace.should eq nil
    cb.super_class.namespace.should eq "jsk"
    cb.super_class.class_name.should eq "Parent"
  end

  it "should handle non-ns for both self and super" do
    cx = create_class "SingleTest < ParentTest"
    cx.class_name.should eq "SingleTest"
    cx.namespace.should eq nil
    cx.super_class.namespace.should eq nil
    cx.super_class.class_name.should eq "ParentTest"
  end

  it "should handle non-ns inherited" do
    cj = create_class "jsk::BaseClass < Map"
    cj.class_name.should eq "BaseClass"
    cj.namespace.should eq "jsk"
    cj.super_class.class_name.should eq "Map"
    cj.super_class.namespace.should eq nil
  end

  it "should handle non inheritance, non ns" do
    cp = create_class "FooBar"
    cp.class_name.should eq "FooBar"
    cp.namespace.should eq nil
    cp.super_class.should eq nil
  end
end


