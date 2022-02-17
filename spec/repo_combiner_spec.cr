require "./spec_helper"

describe RepoCombiner do
  it "initializes the target directory with a blank repo" do
    combiner = RepoCombiner.new
    File.exists?("#{combiner.target_dir}/.git").should eq true
    FileUtils.rm_rf(combiner.target_dir)
  end

  it "can combine conflicting repos" do
    combiner = RepoCombiner.new
    combiner.add_repo("https://github.com/sam0x17/repo_combiner.git", "main")
    combiner.add_repo("https://github.com/sam0x17/assert.cr.git", "master")
    File.exists?("#{combiner.target_dir}/src/assert.cr").should eq true
    File.exists?("#{combiner.target_dir}/src/repo_combiner.cr").should eq true
    FileUtils.rm_rf(combiner.target_dir)
  end
end
