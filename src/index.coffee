# Description:
#   Show pull-requests
#
# Commands:
#   hubot show prs - Show organizations pull-requests
#
# Author:
#   Shinichi Okamoto

github = require './github/github.coffee'

eachPullRequests = (repository, msg) ->
  if repository.isPrivate
    for pullRequest in repository.pullRequests.nodes
      msg.send(
        attachments: [
          title: "[#{repository.name}]#{pullRequest.title}"
          title_link: pullRequest.url
          text: pullRequest.body
          color: 'info'
        ]
      )
  else
    for pullRequest in repository.pullRequests.nodes
      msg.send(pullRequest.url)

eachRepos = (nodes, filter, msg) ->
  for repository in nodes
    if (!filter || repository.name.indexOf(filter) >= 0)
      eachPullRequests(repository, msg)

module.exports = (robot) ->
  robot.respond /show prs? (.*)\/(.*)/, (msg) ->
    owner = msg.match[1]
    repository = msg.match[2]
    github.repoPRs owner, repository, (err, httpResponse, body) ->
      json = JSON.parse(body)
      repo = json.data.repository
      eachPullRequests(repo, msg)

  robot.respond /show prs? ?(.*)?/, (msg) ->
    filter = msg.match[1]
    github.userPRs (err, httpResponse, body) ->
      json = JSON.parse(body)
      repos = json.data.viewer.repositories.nodes
      eachRepos(repos, filter, msg)


  robot.respond /show prs? org ?(.*)?/, (msg) ->
    filter = msg.match[1]
    github.orgPRs (err, httpResponse, body) ->
      json = JSON.parse(body)
      orgs = json.data.viewer.organizations.nodes
      for org in orgs
        eachRepos(org.repositories.nodes, filter, msg)
