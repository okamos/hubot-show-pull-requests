request = require 'request'
RLIMIT = process.env.HUBOT_GITHUB_REPOS_LIMIT | 100 # default
PLIMIT = process.env.HUBOT_GITHUB_PR_LIMIT | 100 # default

class Form
  constructor: (body) ->
    @data = {
      url: 'https://api.github.com/graphql'
      headers: {
        'Authorization': "Bearer #{process.env.HUBOT_GITHUB_TOKEN}"
        'User-Agent': 'npm-request'
      }
      body: body
    }

orgPRs = (callback) ->
  form = new Form("{\"query\":\"query{viewer{organizations(first:#{10}){nodes{repositories(first:#{RLIMIT}){nodes{name isPrivate pullRequests(first:#{PLIMIT},states:OPEN){nodes{url title body}}}}}}}}\"}")
  request.post(form.data, callback)

userPRs = (callback) ->
  form = new Form("{\"query\":\"query{viewer{repositories(first:#{RLIMIT}){nodes{name isPrivate pullRequests(first:#{PLIMIT},states:OPEN){nodes{url title body}}}}}}\"}")
  request.post(form.data, callback)

repoPRs = (owner, repository, callback) ->
  form = new Form("{\"query\":\"query{repository(owner:\\\"#{owner}\\\",name:\\\"#{repository}\\\"){name isPrivate pullRequests(first:#{PLIMIT},states:OPEN){nodes{url title body}}}}\"}")
  request.post(form.data, callback)

module.exports = {
  orgPRs
  userPRs
  repoPRs
}
