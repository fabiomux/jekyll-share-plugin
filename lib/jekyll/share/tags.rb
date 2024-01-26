# frozen_string_literal: true

require "share_with"

module Jekyll
  module Share
    #
    # Single service rendering.
    #
    class Single < Liquid::Tag
      include Helper

      def initialize(tag_name, text, tokens)
        super
        @@share_single ||= {}
        @text = text
      end

      def render(context)
        @params = init_params(@text, context)
        if @@share_single.key? @name
          @@share_single[@name].reset!
        else
          @@share_single[@name] = ShareWith::Service.new @name,
                                                         extend_with: @extend_with,
                                                         paths: Config.paths
        end

        @params = if preview?(context)
                    extract_preview_data(context).merge @params
                  else
                    extract_page_data(context).merge @params
                  end

        @params.each do |key, value|
          @@share_single[@name].set_conditional_param(key, value)
        end

        @@share_single[@name].render(@template)
      end

      private

      def init_params(text, context)
        params = text.split_params(context)
        @name = params["name"]
        params.delete("name")
        raise MissingService if @name.nil? || @name.empty?

        @template = params["template"] || "icon"
        params.delete("template")
        @extend_with = params["extend_with"]
        params.delete("extend_with")

        params
      end
    end

    #
    # Group of services.
    #
    class Group < Liquid::Tag
      include Helper

      def initialize(tag_name, text, tokens)
        super
        @@share_groups ||= {}
        @text = text
      end

      def render(context)
        @params = init_params(@text, context)
        if @@share_groups.key? @name
          @@share_groups[@name].reset_all!
        else
          @@share_groups[@name] = ShareWith::Collection.new extend_with: @extend_with,
                                                            services: @services,
                                                            paths: Config.paths
        end

        @params = if preview?(context)
                    @params.merge extract_preview_data(context)
                  else
                    @params.merge extract_page_data(context)
                  end

        @params.each do |key, value|
          @@share_groups[@name].set_conditional_param(key, value)
        end

        res = [@wrappers["group_start"].to_s]
        @@share_groups[@name].render_all(@template).each do |_k, v|
          res << "#{@wrappers["service_start"]}#{v}#{@wrappers["service_end"]}"
        end
        res << @wrappers["group_end"].to_s

        res.join("\n")
      end

      private

      def init_params(text, context)
        params = text.split_params(context)
        @name = params["name"] || "default"
        params.delete("name")

        gcfg = GroupConfig.new(@name)
        @template = params["template"] || gcfg.template
        params.delete("template")
        @wrappers = gcfg.wrappers

        @extend_with = gcfg.extend_with
        @services = gcfg.services

        params["icon_size"] ||= gcfg.icon_size

        params
      end
    end
  end
end
