#
# Jekyll GPG Clearsign
#
# Author : Rob Smith
# Repo   : http://github.com/kormoc/jekyll-gpg_clearsign
# Version: 0.04
# License: MIT, see LICENSE file
#

require 'GPGME'

module GPGClearsign
  class GPGClearsignGenerator < Jekyll::Generator
    def generate(site)
      if !site.config.has_key?("GPGClearsign") or !site.config["GPGClearsign"]
        return
      end

      site.pages.each { |p| clearsign p }
      site.posts.each { |p| clearsign p }
    end

    private
    def clearsign(obj)
      if not obj.url =~ /^\.html$/i
        return
      end

      if obj.data.has_key?("GPGClearsign") and !obj.data["GPGClearsign"]
        return
      end

      # Non-rendered liquid markup
      if obj.content.include? '{{'
        return
      end

      # Non-rendered liquid tags
      if obj.content.include? '{%'
        return
      end

      crypto = GPGME::Crypto.new
      obj.content.prepend("\n-->\n")
      obj.content << "\n<!--\n"
      obj.content = (crypto.clearsign obj.content).to_s
      obj.content.prepend("\n<!--\n")
      obj.content << "\n-->\n"
    end
  end
end

module Jekyll
  module GPGClearsignFilter
    def gpg_clearsign(content)

      # Already signed?
      if content.include? '-----BEGIN PGP SIGNED MESSAGE-----'
        return content
      end

      content.prepend("\n                    \n-->\n")
      content << "\n<!--\n                    \n"
      content = (GPGME::Crypto.new.clearsign content).to_s
      content.prepend("\n<!--\n                    \n")
      content << "\n                    \n-->\n"

      return content
    end
  end
end

Liquid::Template.register_filter(Jekyll::GPGClearsignFilter)
