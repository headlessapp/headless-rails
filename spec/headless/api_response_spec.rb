require "spec_helper"

RSpec.describe Headless::APIResponse do

  let(:successful) do
    {
      "success" => true,
      "status"  => "success",
      "url"     => "http://example.com",
      "title"   => "Title",
      "content" => "<h1>Title</h1>",
      "http_status_code" => 200
    }
  end

  let(:failed) do
    {"success"=>false, "status"=>"fail"}
  end

  context "success" do
    subject do
      Headless::APIResponse.new(JSON.dump(successful))
    end

    it "parses the content" do
      expect(subject.content).to eq("<h1>Title</h1>")
    end

    it "returns true for success?" do
      expect(subject.success?).to be_true
    end

    it "returns the http status code" do
      expect(subject.http_status_code).to be(200)
    end
  end

  context "failure" do
    subject do
      Headless::APIResponse.new(JSON.dump(failed))
    end

    it "returns false for success?" do
      expect(subject.success?).to be_false
    end
  end
end
