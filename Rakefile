#
# BUILD WORKFLOW
#

# Before brunch build, after hugo done
# /build/assets <- normal assets from `static` dir
# After brunch build
# /build/assets <- overwritten with minified assets (CSS|JS only)

# Pretend `build` is a task
# task build: %w[build:run]

# RAKE TASK PARAMS
# http://stackoverflow.com/a/825864/1592582

require 'sshkit'
require 'sshkit/dsl'

namespace :build do

  # Abstract build task, requires build_dir as first arg
  task :build, [:build_dir] do |t, args|
    run_locally do
      execute :hugo, '--destination', args[:build_dir]

      # Brunch compilation. Setting env var using `with`.
      # See brunch config for details
      with brunch_env: :production do
        execute :brunch, 'build'
      end
    end
  end

  # Abstract task, requires build_dir as first arg
  task :rm_dir, [:build_dir] do |t, args|
    run_locally do
      if test "[ -d #{args[:build_dir]} ]"
        execute :rm, '-Rf', args[:build_dir]
      end
    end
  end
end

#
# DEPLOY
#

require_relative 'deploy/github.rb'

# TODO: Fix if needed (using github pages now)
# require_relative 'deploy/vps.rb'
