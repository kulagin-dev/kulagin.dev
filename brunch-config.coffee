exports.config =
  # See https://github.com/brunch/brunch/blob/master/docs/config.md

  notifications: ['error', 'warn', 'info']
  fileListInterval: 100
  npm:
    enabled: false

  conventions:
    # Will check against files that should be ignored by brunch compiler, but are
    # still watched by the watcher. For example, when you have common.styl file that
    # you import in every stylus file, common.styl will be compiled on its own too
    # which will result in duplicated code. When prefixing it with underscore
    # (_common.styl) you are still able to import it in dependent files, but it won’t
    # be compiled twice. The feature is very similar to Sass partials. By default,
    # files and directories that start with underscore (_) will be ignored, as well as
    # anything under the vendor/node/, vendor/ruby-*/, vendor/jruby-*/, and
    # vendor/bundle/ directories.

    # ignored: false

    # DON'T COPY `assets` DIR
    # Default value: /assets[\\/]/. If test gives true, file won't be compiled
    # and will be just moved to public directory instead.

    assets: []

    # If test gives true, file won't be wrapped in module, if there are any.

    # vendor: false

  paths:
    public: 'static/assets'
    watched: ['assets'] # recursive

  files:
    stylesheets:
      joinTo:
        # Do not grub subdirs (or else use something like /^((?!twbs).)*$/ + **/* in array)
        'main.css': 'assets/css/main.scss'

    javascripts:
      joinTo:
        'main.js': 'assets/js/main.js'
        # Select required (and skip jquery) files using `overrides` in bower.js
        'vendor.js': /^bower_components\/(js-cookie)/

  plugins:
    # See https://github.com/brunch/sass-brunch
    sass:
      mode: 'native' # libsaas

  overrides:
    production:
      optimize: true
      sourceMaps: false
      paths:
        public: 'build/assets'

      # These plugins only run then optimize == true
      plugins:
        uglify:
          compress:
            global_defs:
              DEBUG: false

        cleancss:
          keepSpecialComments: 0
          removeEmpty: true

        # Add ngx_http_gzip_static_module support
        gzip:
          paths:
            # We keep all assets in one dir, so take them from there
            javascript: '.'
            stylesheet: '.'

  modules:
    # Replace default brunch wrapper
    definition: false
    wrapper: false
