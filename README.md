# Nexmo SMS Action

Send an SMS from [GitHub Actions](https://github.com/features/actions) using [Nexmo](https://www.nexmo.com/). 

For additional details, see the blog post [Send SMS with GitHub Actions](https://www.nexmo.com/blog/2019/02/08/send-sms-github-actions-dr/)

## Usage

```workflow
name: Push to master
on: [push]
jobs:
  send-sms:
    name: Send SMS
    runs-on: ubuntu-latest
    steps:
    - name: Send SMS
      uses: nexmo-community/nexmo-sms-action@update-to-v2
      env:
        NEXMO_API_KEY: ${{ secrets.NEXMO_API_KEY }}
        NEXMO_API_SECRET: ${{ secrets.NEXMO_API_SECRET }}
      with:
        nexmoNumber: ${{ secrets.NEXMO_NUMBER }}
        recipientNumber: 14155512345
        message: "New push on ${{ github.repository }} from ${{ github.actor }}"
```

will send `New push on org-name/repo-name from your_username` to `14155512345`. 

If you don't want to expose your recipient number, you can use secrets.

For example, a new secret called `DEVOPS_NUMBER` could be used inside of `args` as follows:

```workflow
name: Push to master
on: [push]
jobs:
  send-sms:
    name: Send SMS
    runs-on: ubuntu-latest
    steps:
    - name: Send SMS
      uses: nexmo-community/nexmo-sms-action@master
      env:
        NEXMO_API_KEY: ${{ secrets.NEXMO_API_KEY }}
        NEXMO_API_SECRET: ${{ secrets.NEXMO_API_SECRET }}
      with:
        nexmoNumber: ${{ secrets.NEXMO_NUMBER }}
        recipientNumber: ${{ secrets.RECIPIENT_NUMBER }}
        message: "New push on ${{ github.repository }} from ${{ github.actor }}"
```

## Secrets

This action uses the following required secrets:

- `NEXMO_API_KEY` - Your Nexmo API Key.
- `NEXMO_API_SECRET` - Your Nexmo API Secret.
- `NEXMO_NUMBER` - A number on your Nexmo account without any spaces or symbols. Example: 15551231234


## Event Information

GitHub stores the event information in the json file at `$GITHUB_EVENT_PATH`. You can use [jq] to parse this file and send its contents in the SMS:

```sh
jq .issue.html_url $GITHUB_EVENT_PATH --raw-output
```

Here's an example of sending an SMS any time an issue is created with the urgent label:

```workflow
workflow "Send SMS On Urgent Issue" {
  resolves = [
    "Send Urgent Issue Message",
  ]
  on = "issues"
}

action "Has Urgent Label" {
  uses = "actions/bin/filter@8738e95"
  args = "label urgent"
}

action "Label Being Added" {
  uses = "actions/bin/filter@8738e95"
  args = "action labeled"
}

action "Send Urgent Issue Message" {
  needs = ["Label Being Added", "Has Urgent Label"]
  secrets = [
    "NEXMO_API_KEY",
    "NEXMO_API_SECRET",
    "NEXMO_NUMBER",
    "DEVOPS_NUMBER",
  ]
  args = "$DEVOPS_NUMBER This urgent issue needs your attention: `jq .issue.html_url $GITHUB_EVENT_PATH --raw-output`"
  uses = "nexmo-community/nexmo-sms-action@master"
}
```

[GitHub Actions]: https://github.com/actions
[Nexmo]: https://developer.nexmo.com
[jq]: https://stedolan.github.io/jq/
