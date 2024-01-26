# frozen_string_literal: true

module Jekyll
  module Share
    #
    # Convert the params to hash
    #
    class ::String
      def split_params(context)
        scan(/(\w+)=(?:(["'])(.+?)\2|([^ ]+))/)
          .to_h do |x|
            x[3] = context[x[3]] if x[1].nil?
            x.delete_at 1
            x.compact
          end
      end
    end

    #
    # Invalid group name error
    #
    class InvalidGroup < StandardError
      def initialize(name)
        super "The group '#{name}' is not valid!"
      end
    end

    #
    # No service name has been specified.
    #
    class MissingService < StandardError
      def initialize
        super "No service name has been specified!"
      end
    end
  end
end
