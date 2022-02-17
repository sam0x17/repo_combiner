require "file_utils"

class RepoCombiner
  property target_dir : String

  def initialize
    @target_dir = unique_dir
  end

  def download_repo(url, dir = nil, branch = nil)
    dir ||= unique_dir
    FileUtils.mkdir_p(dir)
    raise "dir cannot be found!" unless File.exists?(dir)
    puts "Cloning into #{url}..."
    puts `git clone '#{url}' '#{dir}'`
    raise ".git directory cannot be found after cloning!" unless File.exists?("#{dir}/.git")
    if branch
      puts "Checking out into #{branch} branch..."
      puts `git checkout #{branch}`
    end
    dir
  end

  private def unique_dir
    loop do
      dest_dir = "/tmp/#{Random::Secure.hex(8)}"
      return dest_dir unless File.exists?(dest_dir)
    end
  end
end
