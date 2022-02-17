# RepoCombiner

![example workflow](https://github.com/sam0x17/repo_combiner/actions/workflows/main.yml/badge.svg)

RepoCombiner provides an easy CLI interface for combining multiple unrelated git histories (whether
they originate from branches within the same repository, or entirely separate repositories) into
one consolidated repository with a shared git history. This is extremely useful for taking advantage
of analytics services such as GitHub Insights which are unable to perform any useful analysis on a
multi-repo or whole-organization basis (ironically this is true even for GitHub Enterprise customers!).


## Installation

Add the following to the dependencies section of your shard.yml file:
```yaml
dependencies:
  repo_combiner:
    github: sam0x17/repo_combiner
```

## Usage

The following will combine the assert.cr repo and the sepectator repo in an output directory called `output`:
```
./repo_combiner output https://github.com/sam0x17/assert.cr.git https://github.com/icy-arctic-fox/spectator.git
```

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/your-github-user/repo_combiner/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Sam Johnson](https://github.com/sam0x17) - creator and maintainer
