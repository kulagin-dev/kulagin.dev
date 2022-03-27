(function() {
  exports.config = {
    notifications: ['error', 'warn', 'info'],
    fileListInterval: 100,
    npm: {
      enabled: false
    },
    conventions: {
      assets: []
    },
    paths: {
      "public": 'static/assets',
      watched: ['assets']
    },
    files: {
      stylesheets: {
        joinTo: {
          'main.css': 'assets/css/main.scss'
        }
      },
      javascripts: {
        joinTo: {
          'main.js': 'assets/js/main.js',
          'vendor.js': /^node_modules\/(js-cookie)/
        }
      }
    },
    plugins: {
      sass: {
        mode: 'native'
      }
    },
    overrides: {
      production: {
        optimize: true,
        sourceMaps: false,
        paths: {
          "public": 'build/assets'
        },
        plugins: {
          uglify: {
            compress: {
              global_defs: {
                DEBUG: false
              }
            }
          },
          cleancss: {
            keepSpecialComments: 0,
            removeEmpty: true
          },
          gzip: {
            paths: {
              javascript: '.',
              stylesheet: '.'
            }
          }
        }
      }
    },
    modules: {
      definition: false,
      wrapper: false
    }
  };

}).call(this);
