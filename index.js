const core = require('@actions/core');
const Nexmo = require('nexmo');

const nexmo = new Nexmo({
  "apiKey": process.env.NEXMO_API_KEY,
  "apiSecret": process.env.NEXMO_API_SECRET,
});

nexmo.message.sendSms(
  core.getInput('nexmoNumber'),
  core.getInput('recipientNumber'),
  core.getInput('message'),
  function(err, data) {
    if (err) {
     return core.setFailed(err);
    }
  }
);
