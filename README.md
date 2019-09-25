# Nexmo SMS Action

Send an SMS from [GitHub Actions](https://github.com/features/actions) using [Nexmo](https://www.nexmo.com/). 

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
      uses: nexmo-community/nexmo-sms-action@master
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

All of the information attached to an event is available in the `github.event` variable. To see the possible values, you can use the following step in your workflow:

```yaml
- run: echo '${{ toJson(github.event) }}'
```

You can use this information in both the inputs for your action and to run the action conditionally.

Here's an example of sending an SMS any time an issue is created with the urgent label:

```workflow
name: Issue
on:
  issues:
    types: [labeled]
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
        message: "This urgent issue needs your attention: ${{ github.event.issue.html_url }}"
      if: github.event.label.name == 'urgent'
```

[GitHub Actions]: https://github.com/actions
[Nexmo]: https://developer.nexmo.com
[jq]: https://stedolan.github.io/jq/
