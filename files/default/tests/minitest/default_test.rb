require 'minitest/spec'

describe_recipe 'disk::default' do

  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources

  it "should test your cookbook" do
   # service("my_server").must_be_enabled
  end

end
