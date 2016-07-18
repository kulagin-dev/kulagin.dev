# Incapsulate paths-related data
class VpsPaths
  def initialize
    @app_name                   = 'vbru_hugo'
    @deploy_root                = '/hosting/www/vbru'
    @deployed_release_link_name = 'current'
    @releases_dir_name          = 'releases'
    @build_dir                  = 'build'

    @release_timestamp = Time.now.strftime('%Y-%m-%d-%H-%M-%S')
  end

  attr_reader :release_timestamp, :app_name, :deploy_root,
              :deployed_release_link_name, :releases_dir_name, :build_dir

  def deploy_to
    '%s/%s' % [deploy_root, app_name]
  end

  def deployed_release_link_path
    '%s/%s' % [deploy_to, deployed_release_link_name]
  end

  def releases_path
    '%s/%s' % [deploy_to, releases_dir_name]
  end

  # releases/2015..
  def current_release_dir_name
    '%s/%s' % [releases_dir_name, release_timestamp]
  end

  # /hosting/.../releases/2015
  def current_release_dir_path
    '%s/%s' % [deploy_to, current_release_dir_name]
  end

  # This dir will be renamed after upload
  # /hosting/releases/build
  def remote_build_dir_path
    '%s/%s' %[releases_path, build_dir]
  end
end

namespace :build do
  desc "Build locally for VPS"
  task :vps do
    paths = VpsPaths.new

    # Keeping simple (don't like mess with dependent tasks notation)
    Rake::Task['build:rm_dir'].invoke(paths.build_dir)
    Rake::Task['build:build'].invoke(paths.build_dir)
  end
end

namespace :deploy do
  # TODO: DROP DIR ON ERROR (HOOK)

  desc "Build and deploy to VPS"
  task :vps => 'build:vps' do
    paths = VpsPaths.new

    USER              = 'vbru'
    HOST              = 'srv'
    KEEP_RELEASES_NUM = 10

    # COMPRESSION http://net-ssh.github.io/ssh/v1/chapter-2.html
    # NET_SSH v3 breaks compression below, with
    # Net::SSH::Exception: could not settle on compression_client algorithm
    SSHKit::Backend::Netssh.configure do |ssh|
      # ssh.ssh_options = { compression: 'zlib' }
    end

    host = SSHKit::Host.new('%s@%s' % [USER, HOST])

    on host do
      # FOR TESTING ONLY: DROP DEPLOY DIR
      # if test "[ -d  #{paths.deploy_to} ]"
      #   execute :rm, '-Rf', paths.deploy_to
      # end

      # Create releases path
      if test "[ ! -d  #{paths.releases_path} ]"
        execute :mkdir, '-p', paths.releases_path
      end

      # Remove possible previous build dir left
      if test "[ -d #{paths.remote_build_dir_path} ]"
        execute :rm, '-Rf', paths.remote_build_dir_path
      end

      # Uploading to releases/build
      # NOTE: releases dir must exists!
      upload! paths.build_dir, paths.remote_build_dir_path, recursive: true
      warn "Done uploading: #{paths.build_dir} -> #{paths.remote_build_dir_path}"

      # Rename build dir to new release dir
      execute :mv, paths.remote_build_dir_path, paths.current_release_dir_path

      # Relinking 'current' to release. Avoiding full paths here by within
      #
      # -f If the target file already exists, then unlink it so that the link may
      # occur. (The -f option overrides any previous -i options.)
      # -n If the target_file or target_dir is a symbolic link, do not follow it.
      # This is most useful with the -f option, to replace a symlink which may point to a
      # directory
      within paths.deploy_to do
        execute :ln, '-sfn', paths.current_release_dir_name, paths.deployed_release_link_name
      end

      # Cleaning old releases
      #
      # - ls -1 - one node per line
      # - xargs -n - use at most max-args arguments per command line. Useful if amount
      # of args can overflow shell buffer
      # - xargs -d -
      within paths.releases_path do
        cmd = [:ls, '-d *',
               %q{| sort | head -n-%s | xargs -n10 -d '\n' rm -Rf} % KEEP_RELEASES_NUM]

        execute *cmd
      end
    end
  end
end
