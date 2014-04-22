# Some info
# https://github.com/beef/beef-middleman/blob/master/config.rb

# SLIM

set :slim, { pretty: true, format: :html5 }

helpers do
  def some_helper
    "Helping"
  end
end

# COMPASS

compass_config do |config|
  config.output_style = :compact
end

# SPROCKETS

set :debug_assets, true

configure :development do
  activate :livereload do |lr|
    lr[:no_swf] = true
  end
end

# LIVERELOAD

activate :livereload do |lr|
  lr.no_swf = true
end

# Build-specific configuration
configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash

  # Use relative URLs
  # activate :relative_assets
end

# Middleman in dev mode allows duplicated values
after_configuration do
  config[:file_watcher_ignore].push(/^.idea/).uniq!
end

activate :deploy do |deploy|
  deploy.method = :sftp
  deploy.host = 'srv'
  deploy.user = 'vbru'
  deploy.port = 22
  deploy.path = 'public'
  deploy.build_before = true
end

# CUSTOM SETTINGS
set :first_release_date, Time.parse('2014-04-22')
set :days_released, (Time.now - config[:first_release_date]).to_i / (24 * 60 * 60)
