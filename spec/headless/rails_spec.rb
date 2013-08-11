require 'spec_helper'

RSpec.describe Headless::Rails do
  it 'should have a version number' do
    Headless::Rails::VERSION.should_not be_nil
  end

  let(:controller) do
    double(:controller,
      :request => request,
      :params => {},
      :render => nil,
    )
  end

  let(:request) { double(:request) }
  let(:headless_response) { double(:headless_response, :success? => true, :content => :headless_content) }

  describe "respond_to_ajax_crawlers" do
    before do
      controller.extend(Headless::Rails)
    end

    context "with no escaped_fragment" do
      before do
        controller.stub(:params).and_return({})
      end

      it "doesn't call render" do
        expect(controller).to_not receive(:render)

        controller.respond_to_ajax_crawlers
      end

      it "returns nil" do
        value = controller.respond_to_ajax_crawlers
        expect(value).to be_nil
      end
    end

    context "with an escaped fragment" do
      before do
        controller.stub(:params).and_return({"_escaped_fragment_" => "something"})

        expect(Headless::Rails::EscapedFragmentExtractor).to receive(:call).with(request).and_return(:a_url)
        expect(Headless::APIClient).to receive(:crawl).with(:a_url).and_return(headless_response)
      end

      it "extracts the fragment, fetches content from the api, and renders its" do
        expect(controller).to receive(:render).with(:text => :headless_content)

        controller.respond_to_ajax_crawlers
      end

      context "failure" do
        before do
          headless_response.stub(:success?).and_return(false)
        end

        it "doesn't render" do
          expect(controller).to_not receive(:render)

          controller.respond_to_ajax_crawlers
        end
      end
    end
  end
end
