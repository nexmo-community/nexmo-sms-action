# Nexmo SMS Action

Send an SMS from [GitHub Actions] using [Nexmo]. The passed in `args` represent the contents of the message.

## Usage

```bash
workflow "Send SMS On Push" {
  on = "push"
  resolves = ["notification"]
}

action "notification" {
    uses = "cr0wst/nexmo-sms-action@master"
    secrets = [
        "NEXMO_API_KEY",
        "NEXMO_API_SECRET",
        "NEXMO_NUMBER",
        "TO_NUMBER"
    ]
    args = "This is the message to send. You can use environment variables like $GITHUB_REPOSITORY here."
}
```

## Secrets

This action uses the following required secrets:

- `NEXMO_API_KEY` - Your Nexmo API Key.
- `NEXMO_API_SECRETE` - Your Nexmo API Secret.
- `NEXMO_NUMBER` - A number on your nexmo account without any spaces or symbols. Example: 15551231234
- `TO_NUMBER` - The number you wish to send the message to. Example: 15551231234


[GitHub Actions]: https://github.com/actions
[Nexmo]: https://developer.nexmo.com