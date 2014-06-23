Knife-Cleanup
===

This is a [Knife](http://wiki.opscode.com/display/chef/Knife) plugin to help forking cookbook versions. This is particularly useful when you have different cookbook versions between dev and prod environments and you want them to be the same prior to a prod release.

## Installation

You will need chef installed and a working knife config; development has been done on chef 11, but it should work with any version higher than 0.10.10

```bash
gem install knife-cookbook-tagger
```

## Usage

For a list of commands:

```bash
knife cookbooktagger --help
```

Currently there is only one command available:

```bash
knife cookbooktagger -o <original version> -t [<target version>]
```

If you run the command without specifying the target version, then a new cookbook will be generated using the latest version (incrementing the minor version by 1).

Note: this is by no means production ready; I'm using it with success for my needs and hopefully you will find it useful too. Be sure to do a backup your chef server first. 

## Todo/Ideas
  
  * automatically cleanup old cookbook versions

## Development

* Source hosted at [GitHub][repo]
* Report issues/questions/feature requests on [GitHub Issues][issues]

Pull requests are very welcome! Ideally create a topic branch for every separate change you make. For example:

1. Fork the repo
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Authors

Created by [David Gouveia] (<david.gouveia@mail.com>)

## License

Apache License, Version 2.0 (see [LICENSE][license])

[license]:      https://github.com/zatarra/knife-cookbook-tagger/blob/master/LICENSE
[zatarra]:      https://github.com/zatarra
[repo]:         https://github.com/zatarra/knife-cookbook-tagger
[issues]:       https://github.com/zatarra/knife-cookbook-tagger/issues
[knifebackup]:  https://github.com/zatarra/knife-backup
[chefjenkins]:  https://github.com/zatarra/chef-jenkins
