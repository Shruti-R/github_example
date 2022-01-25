require 'github_api'
require 'date'

class PullRequest
  attr_accessor :user
  attr_accessor :repo

  def initialize(args)
    @user = args[:user]
    @repo = args[:repo]
  end

  # Fetch pull requests created in previous week for specified repository and user
  # @return [Array<Array>] details like author, title, state,created_at, url, labels for pull requests
  def filter_prev_week
    prev_week_start_date = Date.today.prev_day(7).strftime("%y-%m-%d")

    pr_details = []
    github = Github.new(user: @user, repo: @repo)
    prev_week_pr = github.pull_requests.list.select {|req| Date.parse(req.created_at) >= Date.parse(prev_week_start_date) }
    prev_week_pr.each { |req|
      req["user_login"] = req.user.login
      req["labels"] = req.labels.map{ |label| label["name"] }
      pr_details << req.fetch_values("user_login", "title", "state", "created_at", "url", "labels")
    }
    return pr_details
  end

end
