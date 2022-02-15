
class RepoCombiner
  def initialize
    puts unique_dir
  end

  def download_repo(url : String, branch : String) : String
    dest_dir = "/tmp/#{Random::Secure.hex(8)}"
  end

  private def unique_dir
    loop do
      dest_dir = "/tmp/#{Random::Secure.hex(8)}"
      return dest_dir unless File.exists?(dest_dir)
    end
  end
end

combiner = RepoCombiner.new
