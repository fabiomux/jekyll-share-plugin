# frozen_string_literal: true

TWITTER_ICON = '<a href="https://twitter.com/share?text=Title%20test&url=https%3A%2F%2Ffree
aptitude.altervista.org%2Fprojects%2Fshare-with.html&related=&hashtags=programming,ruby" title
="Share with Twitter" class="share-with-twitter"><img src="https://cdnjs.cloudflare.com/ajax/
libs/simple-icons/8.6.0/twitter.svg" alt="Share with Twitter" width="48" height="48" /></a>'

FACEBOOK_ICON = '<a href="https://www.facebook.com/sharer.php?u=https%3A%2F%2Ffreeaptitude
.altervista.org%2Fprojects%2Fshare-with.html&t=Title%20test" title="Share with Facebook"
 class="share-with-facebook"><img src="https://cdnjs.cloudflare.com/ajax/libs/simple-icons
/8.6.0/facebook.svg" alt="Share with Facebook" width="48" height="48" /></a>'

RSpec.describe Jekyll::Share::Group do
  describe "Requesting the default group" do
    context "in the page preview" do
      it "prints the services using the icon template" do
        mock_post_preview
        c = Jekyll::Share::Group.send :new, "share_group", "{% share_group name='default' %}", @context
        res = [
          "<ul>",
          "<li>#{TWITTER_ICON.gsub(/\n/, "")}</li>",
          "<li>#{FACEBOOK_ICON.gsub(/\n/, "")}</li>",
          "</ul>"
        ].join("\n")

        expect(c.render(@context)).to eq(res)
      end
    end
  end
end

RSpec.describe Jekyll::Share::Single do
  describe "Requesting the single service" do
    context "in the page preview" do
      it "prints the service using the icon template" do
        mock_post_preview
        c = Jekyll::Share::Single.send :new,
                                       "share_single",
                                       "{% share_single name='twitter' template='icon' %}",
                                       @context
        expect(c.render(@context)).to eq(TWITTER_ICON.gsub(/\n/, ""))
      end
    end
  end
end
