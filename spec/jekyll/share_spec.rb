# frozen_string_literal: true

require_relative "../../lib/jekyll/share/version"

PARAM_STRING = "{% share_group name=\"default\" a=\"b b\" c='d d' e=\"f f\" i=include.post.value %}"

RSpec.describe String do
  describe "The split_params method" do
    context "invoked to decode the params passed in a Liquid layout" do
      it "transforms a string into a key/value hash" do
        mock_post_preview
        expect(PARAM_STRING.split_params(@context)).to \
          eq({ "name" => "default",
               "a" => "b b",
               "c" => "d d",
               "e" => "f f",
               "i" => "post_value" })
      end
    end
  end
end

RSpec.describe Jekyll::Share do
  it "has a version number" do
    expect(Jekyll::Share::VERSION).not_to be nil
  end
end
