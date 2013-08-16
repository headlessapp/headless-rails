require 'spec_helper'

RSpec.describe Headless::Rails do
  it 'should have a version number' do
    Headless::Rails::VERSION.should_not be_nil
  end
end
