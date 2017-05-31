# Description:
#   Show pull-requests
#
# Commands:
#   hubot show prs - Show organizations pull-requests
#
# Author:
#   Shinichi Okamoto

github = require './github/github.coffee'

module.exports = (robot) ->
  robot.respond /show prs?/, (msg) ->
    github.orgPRs (err, httpResponse, body) ->
      json = JSON.parse(body)
      orgs = json.data.viewer.organizations.nodes
      for org in orgs
        for repository in org.repositories.nodes
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
