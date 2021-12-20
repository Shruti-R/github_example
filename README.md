# Github Activity
## Features
- Fetches pull requests for selected Github repository that were created in previous week
- Displays details for pull requests in tabular format

## Pre-requisites
- Requires Ruby >= 2.7 installed

## Usage
- To fetch pull requests for `https://github.com/<user>/<repository>/pulls`, call `github_activity.rb` script passing `--user` and `--repository` name as arguments:
```ruby
$ cd github_example
$ ruby github_activity.rb --help
$ ruby github_activity.rb --user "<user name>" --repo "<repository name>"
```

### Default
- When `user` and `repository` arguments are skipped, `github_activity.rb` script fetches pull requests for default repository and user "puma" i.e.  `https://github.com/puma/puma/pulls`:
```ruby
$ ruby github_activity.rb
```
### Example
- To fetch pull requests for https://github.com/rails/rails/pulls:
```ruby
$ ruby github_activity.rb --user "rails" --repo "rails"
```
