# frozen_string_literal: true

require "jekyll"

require_relative "share/config"
require_relative "share/helper"
require_relative "share/tags"
require_relative "share/utils"

Liquid::Template.register_tag("share_single", Jekyll::Share::Single)
Liquid::Template.register_tag("share_group", Jekyll::Share::Group)
