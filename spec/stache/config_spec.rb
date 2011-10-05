require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Stache::Config" do
  describe "attributes" do
    before do
      Stache.send(:instance_variable_set, :@template_base_path, nil)
    end
    [:template_base_path, :template_extension, :shared_path].each do |attr|
      it "sets up an attribute named #{attr.to_s}" do
        Stache.should respond_to(attr)
        Stache.should respond_to("#{attr}=")
      end
      
      it "sets up a default value for #{attr}" do
        Stache.send(attr).should_not be_nil
        Stache.send(attr).should == if attr == :template_base_path
          ::Rails.root.join('app', 'templates')
        elsif attr == :template_extension
          "html.mustache"
        elsif attr == :shared_path
          ::Rails.root.join('app', 'templates', 'shared')
        end
      end
    end
  end
  
  describe ".configure" do
    it "yields self to the block as a convienence to future refactoring" do
      Stache.configure do |config|
        config.template_base_path = "/dev/null"
      end
      Stache.template_base_path.should == Pathname.new("/dev/null")
    end
  end
  
end