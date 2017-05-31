# hubot-show-pull-requests
hubot-show-pull-requests shows OPEN pull-requests

## Installation
```bash
$ npm install hubot-show-pull-requests
$ # if you use Yarn
$ yarn add hubot-show-pull-requests
```

Add `hubot-show-pull-requests` to `external-scripts.json`.

```json
[
  ...
  'hubot-show-pull-requests',
  ...
]
```

## Configuration
```bash
HUBOT_GITHUB_TOKEN=your_token # required. Your GitHub access token.
HUBOT_GITHUB_REPOS_LIMIT=100 # optional. Number of display repositories. default 100
HUBOT_GITHUB_PR_LIMIT=100 # optional. Number of display pull requests. default 100
exec node_modules/.bin/hubot --name "hubot" "$@"
```

![permit organization](https://raw.githubusercontent.com/okamos/hubot-show-pull-requests/master/assets/edit_access_token.png)


## Usage
```bash
okamos> hubot show prs
hubot> (list of users repositories url)

okamos> hubot show prs org
hubot> (list of organizations pull-requests)

okamos> hubot show prs filter
hubot> (list of filtered users pull-requests)

okamos> hubot show username/repository
hubot> (list of repository pull-requests)
```
