# frozen_string_literal: true

require "liquid"
require_relative "../lib/jekyll/share"

def init_mock
  @context = Liquid::ParseContext.new
  config = double("config")
  config_yml = {
    "jekyll-share" => {
      "mappings" => {
        "twitter:hashtags" => "@tags"
      },
      "groups" => {
        "default" => {
          "template" => "icon",
          "wrappers" => {
            "service_start" => "<li>",
            "service_end" => "</li>",
            "group_start" => "<ul>",
            "group_end" => "</ul>"
          },
          "services" => %w[twitter facebook]
        }
      }
    }
  }
  allow(config).to receive(:config).and_return(config_yml)

  allow(@context).to receive(:line_number) { "" }
  allow(@context).to receive(:registers) do
    {
      site: config,
      page: {
        "layout" => "post"
      }
    }
  end
  allow(Jekyll).to receive(:configuration).and_return(config_yml)
end

def mock_post_preview
  init_mock
  allow(@context).to receive(:[]) do |x|
    case x
    when "site.url"
      "https://freeaptitude.altervista.org"
    when "include.post.date"
      "2023-02-28 09:56"
    when "include.post.title"
      "Title test"
    when "include.post.tags"
      "programming ruby"
    when "include.post.url"
      "/projects/share-with.html"
    when "include.post.value"
      "post_value"
    end
  end
end

def mock_page
  init_mock
  allow(@context).to receive(:[]) do |x|
    case x
    when "include.post.date",
         "include.post.title",
         "include.post.tags",
         "include.post.url"
      nil
    end
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
