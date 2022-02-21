require "file_utils"
require "./cli"

class RepoCombiner
  property target_dir : String
  property verbose : Bool = true

  VERSION = "0.1.0"

  def initialize(target_dir = nil)
    @target_dir = target_dir ? target_dir.not_nil! : unique_dir
    @initial = true
    pwd = FileUtils.pwd
    FileUtils.mkdir_p(@target_dir)
    FileUtils.cd @target_dir
    git_cmd "git init"
    git_cmd "git add --all", false
    git_cmd "git commit --allow-empty -m 'initial commit'", false
    git_cmd "git status", false
    raise "could not initialize git repo" unless File.exists?(".git")
  ensure
    FileUtils.cd pwd if pwd
  end

  def add_repo(url, branch = "master", subdir = unique_subdir("."))
    pwd = FileUtils.pwd
    FileUtils.cd @target_dir.not_nil!
    git_cmd "git subtree add --prefix #{subdir} '#{url}' #{branch}", false
    subdir
  ensure
    FileUtils.cd pwd if pwd
  end

  private def vputs(msg)
    puts msg if @verbose
  end

  private def git_cmd(cmd, quiet = !@verbose)
    vputs cmd
    vputs `#{cmd} #{quiet ? "--quiet" : ""}`
  end

  private def unique_dir
    unique_subdir("/tmp")
  end

  private def unique_subdir(dir)
    loop do
      dest_dir = "#{dir}/#{Random::Secure.hex(5)}"
      dest_dir = dest_dir[2..] if dest_dir.starts_with?("./")
      return dest_dir unless File.exists?(dest_dir)
    end
  end
end
