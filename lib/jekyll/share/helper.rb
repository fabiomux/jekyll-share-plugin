# frozen_string_literal: true

module Jekyll
  module Share
    #
    # Contains the methods to calculate the Disqus ID associated to
    # a post or a page.
    #
    module Helper
      def preview?(context)
        return true if context["#{Config.post_selector}.title"]
      end

      def extract_page_data(context)
        extract_data "page", context
      end

      def extract_preview_data(context)
        extract_data Config.post_selector, context
      end

      private

      # rubocop:disable Metrics/PerceivedComplexity
      # rubocop:disable Metrics/CyclomaticComplexity
      def extract_data(selector, context)
        res = {}
        res["title"] = context["#{selector}.title"]
        res["url"] = context["site.url"].to_s +
                     context["site.base_dir"].to_s +
                     context["#{selector}.url"]
        res["tags"] = context["#{selector}.tags"]
        res["categories"] = context["#{selector}.categories"]

        if res["tags"].instance_of? String
          res["tags"] = res["tags"].split.join(",")
        elsif res["tags"].instance_of? Array
          res["tags"] = res["tags"].join(",")
        end

        if res["categories"].instance_of? String
          res["categories"] = res["categories"].split.join(",")
        elsif res["tags"].instance_of? Array
          res["categories"] = res["categories"].join(",")
        end

        Config.mappings.each do |k, v|
          res[k] = if v[0] == "@"
                     param = v.delete("@")
                     if res.key?(param)
                       res[param]
                     else
                       context.key?(param) ? context[param] : context["#{selector}.#{param}"]
                     end
                   else
                     v
                   end
        end

        res
      end
      # rubocop:enable Metrics/PerceivedComplexity
      # rubocop:enable Metrics/CyclomaticComplexity
    end
  end
end
