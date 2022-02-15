require "file_utils"

class RepoCombiner
  property target_dir : String

  def initialize
    @target_dir = unique_dir
  end

  def download_repo(url, target_dir, branch = nil)
    raise "target_dir cannot be found!" unless File.exists?(target_dir)
    puts "Cloning into #{url}..."
    FileUtils.mkdir_p(target_dir)
    puts `git clone '#{url}' '#{target_dir}'`
    raise ".git directory cannot be found after cloning!" unless File.exists?("#{target_dir}/.git")
    if branch
      puts "Checking out into #{branch} branch..."
      puts `git checkout #{branch}`
    end
  end

  private def unique_dir
    loop do
      dest_dir = "/tmp/#{Random::Secure.hex(8)}"
      return dest_dir unless File.exists?(dest_dir)
    end
  end
end

combiner = RepoCombiner.new
