unless ENV["TEST_MODE"]?
  if ARGV.empty? || ARGV.first == "help" || ARGV.first == "--help"
    puts ""
    puts "repo_combiner v#{RepoCombiner::VERSION}"
    puts ""
    puts "usage: repo_combiner <target_dir> [git_url_1|branch] [git_url_2|branch]"
    puts "       repo_combiner <target_dir> [git_url_1|branch] [git_url_2|branch] [git_url_3|branch]"
    puts "       ..."
    puts ""
  else
    raise "target_dir should not end in .git!" if ARGV.first.downcase.ends_with?(".git")
    github_token = ENV["GH_TOKEN"]?
    combiner = RepoCombiner.new(ARGV.first, github_token)
    combiner.verbose = true
    ARGV.last(ARGV.size - 1).each do |pair|
      url = pair
      branch = "master"
      if pair.includes?("|")
        pair = pair.split("|")
        url = pair[0]
        branch = pair[1]
      end
      puts "adding #{url} : #{branch}..."
      combiner.add_repo(url, branch)
    end
    puts "all repos combined and added to #{combiner.target_dir}"
  end
end
