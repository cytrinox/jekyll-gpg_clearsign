# Jekyll GPG Clearsign

Jekyll GPG Clearsign is a Jekyll plugin for clear signing your posts via GPG.
We wrap the armor in html comments, but will verify entirely correct if copied
from '-----BEGIN PGP SIGNED MESSAGE-----' to '-----END PGP SIGNATURE-----',
including the added --> and <!-- comments inside of the armor.

## Installation

Copy or link `gpg_clearsign.rb` into your `_plugins` folder
for your Jekyll project.

If your Jekyll project is in a git repository, you can easily
manage your plugins by utilizing git submodules.

To install this plugin as a git submodule:

    git submodule add git://github.com/kormoc/jekyll-gpg_clearsign.git _plugins/gpg_clearsign

To update:

    cd _plugins/gpg_clearsign
    git pull origin master

Set your default layout to use `{{ content | gpg_clearsign }}` vs `{{ content }}`
or enable it globally via enabling GPGClearsign in `_config.yml`. GPGClearsign
only works for completely static pages. Any liquid templates will break the
validation. This is why `{{ content | gpg_clearsign }}` is the recommended usage.

## Dependencies

 * Ruby Gem [gpgme](https://github.com/ueno/ruby-gpgme)

## Author

Rob Smith, [kormoc](https://github.com/kormoc) on GitHub

## License

[MIT](http://opensource.org/licenses/MIT), see LICENSE file.
