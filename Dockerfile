FROM node:10

LABEL "com.github.actions.name"="Nexmo Send SMS"
LABEL "com.github.actions.description"="Send an SMS using Nexmo."
LABEL "com.github.actions.icon"="smartphone"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="http://github.com/nexmo-community/nexmo-sms-action"
LABEL "homepage"="http://developer.nexmo.com"
LABEL "maintainer"="Steve Crow <steve.crow@nexmo.com>"

RUN npm install -g nexmo-cli

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]