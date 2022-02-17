require "file_utils"

class RepoCombiner
  property target_dir : String
  property verbose : Bool = false

  def initialize
    @target_dir = unique_dir
    FileUtils.mkdir_p(@target_dir)
    git_cmd "git init #{@target_dir}"
    raise "could not initialize git repo" unless File.exists?("#{@target_dir}/.git")
  end

  def download_repo(url, dir = nil, branch = nil)
    dir ||= unique_dir
    FileUtils.mkdir_p(dir)
    raise "dir cannot be found!" unless File.exists?(dir)
    git_cmd "git clone '#{url}' '#{dir}'"
    raise ".git directory cannot be found after cloning!" unless File.exists?("#{dir}/.git")
    if branch
      git_cmd "git checkout #{branch}"
    end
    dir
  end

  private def vputs(msg)
    puts msg if @verbose
  end

  private def git_cmd(cmd)
    vputs cmd
    vputs `#{cmd} #{@verbose ? "" : "--quiet"}`
  end

  private def unique_dir
    loop do
      dest_dir = "/tmp/#{Random::Secure.hex(8)}"
      return dest_dir unless File.exists?(dest_dir)
    end
  end
end
