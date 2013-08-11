require 'spec_helper'

RSpec.describe Headless::Rails::EscapedFragmentExtractor do

  def request_with_fragment(escaped_fragment)
    double(:request,
      :protocol => "http://",
      :host_with_port => "localhost:3000",
      :path => "/user/matthewrudy",
      :GET => {
        "_escaped_fragment_" => escaped_fragment,
      }
    )
  end

  describe "call" do

    context "with an empty escaped_fragment" do
      subject do
        described_class.call(request_with_fragment(""))
      end

      it "returns a full url with the escaped fragment removed" do
        expect(subject).to eq "http://localhost:3000/user/matthewrudy"
      end
    end

    context "with an escaped_fragment" do
      subject do
        described_class.call(request_with_fragment("/show/twitter"))
      end

      it "returns the full url with an anchor appended" do
        expect(subject).to eq "http://localhost:3000/user/matthewrudy#/show/twitter"
      end
    end
  end
end