#
# Jekyll GPG Clearsign
#
# Author : Rob Smith
# Repo   : http://github.com/kormoc/jekyll-gpg_clearsign
# Version: 0.02
# License: MIT, see LICENSE file
#

require 'GPGME'

module GPGClearsign
  class GPGClearsignGenerator < Jekyll::Generator
    def generate(site)
      if site.config.has_key?("GPGClearsign") and !site.config["GPGClearsign"]
        return
      end
      
      site.pages.each { |p| clearsign p }
      site.posts.each { |p| clearsign p }
    end
    
    private
    def clearsign(obj)
      if obj.data.has_key?("GPGClearsign") and !obj.data["GPGClearsign"]
        return
      end
      
      crypto = GPGME::Crypto.new
      print obj.content
      obj.content.prepend("\n-->\n")
      obj.content << "\n<!--\n"
      obj.content = (crypto.clearsign obj.content).to_s
      obj.content.prepend("\n<!--\n")
      obj.content << "\n-->\n"
      return
    end
  end
end
