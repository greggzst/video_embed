class VideoEmbed
  class Vimeo 
    def url?(url)
      url.host =~ /vimeo.com/
    end

    def embed(url, options = {})
      vimeo_url = Vimeo::Url.new(url, options)
      vimeo_url.embed
    end

    class Url
      attr_reader :url, :width, :height

      def initialize(url, options = {})
        @url = url
        @width = options.fetch(:width, 560)
        @height = options.fetch(:height, 315)
      end

      def embed
        %Q{<iframe src="http://player.vimeo.com/video/#{video_id}?title=0&amp;byline=0&amp;portrait=0" width="#{width}" height="#{height}" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>}
      end

      private
      
      def video_id
        if url.to_s =~ /album\/\d*\/video\//
          url.to_s.match(/vimeo.com(?:\/m)?\/album\/\d*\/video\/(\d*)\??/)[1]
        elsif url.to_s =~ /channels\/\w*\/(\d*)\??/
          url.to_s.match(/vimeo.com(?:\/m)?\/channels\/\w*\/(\d*)\??/)[1]
        else
          url.to_s.match(/vimeo.com(?:\/m)?\/(\d*)\??/)[1]
        end
      end
    end
  end
end

