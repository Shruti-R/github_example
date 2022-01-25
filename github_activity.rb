require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'github_api'
  gem 'terminal-table'
end

require 'optparse'
require 'terminal-table'
require_relative 'pull_request'

#  Default arguments
args = {
  :user => "puma",
  :repo => "puma"
}

OptionParser.new do |opt|
  opt.banner = "Usage: github_pull_requests.rb [options]"
  opt.on('-u', '--user String', 'Github Repository User, default is "puma"') { |o| args[:user] = o }
  opt.on('-r', '--repo String', 'Github Repository Name, default is "puma"') { |o| args[:repo] = o }
end.parse!

# Fetch pull requests for specified user and repository and display details in tabular format
# Handle exception if there were errors fetching pull requests
begin
  requests = PullRequest.new(args).filter_prev_week
  formatted_pr_details = Terminal::Table.new :title => "Pull Requests for #{args[:user]}/#{args[:repo]}",
                                             :headings => ['Author', 'Title', 'State', 'Created At', 'URL', 'Label'],
                                             :rows => requests
  puts formatted_pr_details
rescue StandardError => error
  puts "Error fetching pull requests for #{args[:user]}/#{args[:repo]}"
  puts error.message
end
