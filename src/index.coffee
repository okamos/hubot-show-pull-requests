# Description:
#   Show pull-requests
#
# Commands:
#   hubot show prs - Show organizations pull-requests
#
# Author:
#   Shinichi Okamoto

github = require './github/github.coffee'

eachRepos = (nodes) ->
  for repository in nodes
    if repository.isPrivate
      for pullRequest in repository.pullRequests.nodes
        msg.send(
          attachments: [
            title: pullRequest.title
            title_link: pullRequest.url
            text: pullRequest.body
            color: 'info'
          ]
        )
    else
      for pullRequest in repository.pullRequests.nodes
        msg.send(pullRequest.url)

module.exports = (robot) ->
  robot.respond /show prs?/, (msg) ->
    github.userPRs (err, httpResponse, body) ->
      json = JSON.parse(body)
      repos = json.data.viewer.repositories.nodes
      eachRepos(repos)


  robot.respond /show prs? org/, (msg) ->
    github.orgPRs (err, httpResponse, body) ->
      json = JSON.parse(body)
      orgs = json.data.viewer.organizations.nodes
      for org in orgs
        eachRepos org.repositories.nodes
