# Nexmo SMS Action

Send an SMS from [GitHub Actions] using [Nexmo]. The passed in `args` represent the contents of the message.

## Usage

The `args` represent the recipient and the contents of the message. 

For example:

```bash
workflow "Send SMS On Push" {
  on = "push"
  resolves = ["notification"]
}

action "notification" {
    uses = "nexmo-community/nexmo-sms-action@master"
    secrets = [
        "NEXMO_API_KEY",
        "NEXMO_API_SECRET",
        "NEXMO_NUMBER",
        "TO_NUMBER"
    ]
    args = "15551234567 New pull on $GITHUB_REPOSITORY from $GITHUB_ACTOR."
}
```

will send `New pull on $GITHUB_REPOSITORY from $GITHUB_ACTOR` to `15551234567`. 

If you don't want to expose your recipient number, you can use secrets.

For example, a new secret called `DEVOPS_PHONE` could be used inside of `args` as follows:

```bash
workflow "Send SMS On Push" {
  on = "push"
  resolves = ["notification"]
}

action "notification" {
    uses = "nexmo-community/nexmo-sms-action@master"
    secrets = [
        "NEXMO_API_KEY",
        "NEXMO_API_SECRET",
        "NEXMO_NUMBER",
        "TO_NUMBER"
    ]
    args = "$DEVOPS_PHONE New pull on $GITHUB_REPOSITORY from $GITHUB_ACTOR."
}
```

This allows for you to reuse this action to send messages to various recipients.

## Secrets

This action uses the following required secrets:

- `NEXMO_API_KEY` - Your Nexmo API Key.
- `NEXMO_API_SECRETE` - Your Nexmo API Secret.
- `NEXMO_NUMBER` - A number on your nexmo account without any spaces or symbols. Example: 15551231234

[GitHub Actions]: https://github.com/actions
[Nexmo]: https://developer.nexmo.com