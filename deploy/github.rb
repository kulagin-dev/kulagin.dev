class GithubPaths

  def initialize
    @build_dir        = 'build'
    @github_build_dir = 'build_github'

    @preserve_files = %w(.git .gitignore CNAME README.md)
    @delete_files   = %w(assets/.gitignore)
  end

  attr_reader :build_dir, :github_build_dir

  def preserve_files
    prefix_path(@preserve_files)
  end

  def delete_files
    prefix_path(@delete_files)
  end

  private

  def prefix_path(files)
    files.map { |f| "#{github_build_dir}/#{f}" }
  end
end

namespace :build do
  desc "Build locally for Github"
  task :github do
    paths = GithubPaths.new

    # Keeping simple (don't like mess with dependent tasks notation)
    Rake::Task['build:rm_dir'].invoke(paths.build_dir)
    Rake::Task['build:build'].invoke(paths.build_dir)
  end
end

namespace :deploy do
  desc "Build and deploy to Github pages"

  task :github => 'build:github' do
    paths = GithubPaths.new

    to_delete = Dir[paths.github_build_dir + '/**/*'] - paths.preserve_files

    run_locally do
      if test "[ -d #{paths.github_build_dir} ]"
        execute :rm, '-Rf', to_delete
      else
        warn "No github build dir exists"
        exit 1
      end

      # Copy build contents into repo dir
      execute :cp, '-R', paths.build_dir + '/*', paths.github_build_dir
      # Removing files we don't want to be in a repo
      execute :rm, '-R', paths.delete_files

      within paths.github_build_dir do
        execute :git, 'add', '.'
        execute :git, 'commit', "-m '#{Time.now.strftime('Deploy @ %F %T %Z')}'"
        execute :git, 'push'
      end
    end
  end
end

