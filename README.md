# Jekyll-Share

This is a Jekyll plugin that provides the Liquid tags to render the sharing services links through the
[ShareWith][share_with] gem.

Using the config section, or defining variables from within the layout template, the target fields can
be customized entirely.

[![Ruby](https://github.com/fabiomux/jekyll-share-plugin/actions/workflows/main.yml/badge.svg)][wf_main]
[![Gem Version](https://badge.fury.io/rb/jekyll-share-plugin.svg)][gem_version]


## Installation

Can install the gem either manually or using *Bundler*.

### Using Bundler

Install the gem and add to the application's Gemfile by executing:

    $ bundle add jekyll-share-plugin --group jekyll_plugins

### Manually

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install jekyll-share-plugin

Then, add the following code within the Gemfile of your Jekyll project:

    ```ruby
    group :jekyll_plugins do
      ...
      gem 'jekyll-share-plugin'
    end
    ```

## Configuration

Inside the `_config.yml` file, set up some or all of the following fields under the `jekyll-share`
section:

    ```yaml
    jekyll-share:
      paths:
      - $HOME/.jekyll-share/services
      mappings:
        twitter:hashtags: '@tags'
        email:subject: '@title'
        # These variables below must be setup in your layout file
        twitter:related: '@related'
        linkedin:summary: '@summary'
        pinterest:media_url: '@media_url'
        email:body: '@str_body'
      post_selector: include.post
      groups:
        default:
          wrappers:
            service_start: '<li class="list-inline-item">'
            service_end: '</li>'
            group_start: '<ul class="list-inline">'
            group_end: '</ul>'
          extend_with:
          - icons.font_awesome
          icon_size: 'medium'
          template: 'icon'
          services:
          - twitter
          - facebook
          - linkedin
          - reddit
          - tumblr
          - telegram
          - flipboard
          - pocket
          - pinterest
    ```

*paths*
: It is the path where other services can be found

*mappings*
: Associate the not standard params with the variables within the layout or include template, or as a field
  part of the front matter in the current document.

*post_selector*
: This is how the script will read the post data inside a paginator layout.

*groups*
: Define the groups of services to render, every group can specify other parameters:

  *wrappers*
  : Defines the HTML tags that wrap the group of links or the single link.

  *extend_with*
  : This implementes the extensions provided by *share_with* gem.

  *icon_size*
  : The size of the icons among the ones defined by *share_with*.

  *template*
  : The default template to use among the ones defined by *share_with*.

  *services*
  : The list of services included in the group.

## Usage

Jekyll-Share provides two Liquid tags that can be used to render the service links:

**share_single**
: Recall the single service to render.
  ```liquid
  {% share_single name='email' %}
  ```

**share_group**
: Recall the group of services as specified in the `.config.yml` file.
  ```liquid
  {% share_group name='default' icon_size=icon_size %}
  ```

## More Help

More info is available at:
- the [project page on the Freeaptitude blog][project_page];
- the [Jekyll-Share Github wiki][jekyll_share_wiki];
- the [ShareWith Github wiki][share_with_wiki].

[share_with]: https://github.com/fabiomux/share_with "ShareWith project page on GitHub"
[share_with_wiki]: https://github.com/fabiomux/share_with/wiki "ShareWith wiki page on GitHub"
[wf_main]: https://github.com/fabiomux/jekyll-share-plugin/actions/workflows/main.yml
[gem_version]: https://badge.fury.io/rb/jekyll-share-plugin
[project_page]: https://freeaptitude.altervista.org/projects/jekyll-share.html "Project page on the Freeaptitude blog"
[jekyll_share_wiki]: https://github.com/fabiomux/jekyll-share-plugin/wiki "Jekyll-Share wiki page on GitHub"
