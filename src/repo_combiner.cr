require "file_utils"
require "./cli"

class RepoCombiner
  property target_dir : String
  property verbose : Bool = false

  def initialize
    @target_dir = unique_dir
    @initial = true
    FileUtils.mkdir_p(@target_dir)
    git_cmd "git init #{@target_dir}"
    raise "could not initialize git repo" unless File.exists?("#{@target_dir}/.git")
  end

  def add_repo(url, branch = "master")
    pwd = FileUtils.pwd
    FileUtils.cd @target_dir.not_nil!
    remote = "rem-#{Random::Secure.hex(5)}"
    git_cmd "git remote add #{remote} #{url}", false
    git_cmd "git fetch #{remote}"
    if @initial
      git_cmd "git reset --hard #{remote}/#{branch}"
      @initial = false
    else
      git_cmd "git rebase #{remote}/#{branch} -s recursive -X theirs"
    end
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
    loop do
      dest_dir = "/tmp/#{Random::Secure.hex(8)}"
      return dest_dir unless File.exists?(dest_dir)
    end
  end
end
