# frozen_string_literal: true

module Jekyll
  module Share
    #
    # Configurations required across the gem.
    #
    class Config
      def self.gconfig
        @@gconfig ||= Jekyll.configuration.freeze
      end

      def self.base_url
        @@base_url ||= gconfig["base_url"].freeze
      end

      def self.url
        @@url ||= gconfig["url"].freeze
      end

      def self.source
        @@source ||= gconfig["source"].freeze
      end

      def self.config
        @@config ||= gconfig["jekyll-share"].freeze
      end

      def self.groups
        @@groups ||= (config["groups"] || []).freeze
      end

      def self.group(name)
        raise InvalidGroup unless groups.key? name

        groups[name]
      end

      def self.mappings
        @@mappings ||= (config["mappings"] || []).freeze
      end

      def self.post_selector
        @@post_selector ||= (config["post_selector"] || "include.post").freeze
      end

      def self.paths
        @@paths ||= (config["paths"] || ["~/.jekyll-share/services"]).freeze
      end
    end

    #
    # Group configurations.
    #
    class GroupConfig
      attr_reader :config

      def initialize(name)
        raise InvalidGroup unless Config.groups.key? name

        @name = name
        @config = Config.groups[name]
      end

      def template
        @config["template"] || "icon"
      end

      def wrappers
        @config["wrappers"] || { "group_start" => "", "group_end" => "",
                                 "service_start" => "", "service_end" => "" }
      end

      def extend_with
        @config["extend_with"] || []
      end

      def services
        @config["services"] || []
      end

      def icon_size
        @config["icon_size"] || "large"
      end
    end
  end
end
