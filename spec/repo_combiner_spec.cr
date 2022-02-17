require "./spec_helper"

describe RepoCombiner do
  it "initializes the target directory with a blank repo" do
    combiner = RepoCombiner.new
    File.exists?("#{combiner.target_dir}/.git").should eq true
    FileUtils.rm_rf(combiner.target_dir)
  end

  it "can download a repo" do
    combiner = RepoCombiner.new
    dir = combiner.download_repo("https://github.com/sam0x17/repo_combiner.git")
    dir.should_not eq nil
    File.exists?(dir).should eq true
    FileUtils.rm_rf(dir)
  end
end
