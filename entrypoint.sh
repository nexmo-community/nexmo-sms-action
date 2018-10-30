#!/bin/sh -l

sh -c "nexmo setup ${NEXMO_API_KEY} ${NEXMO_API_SECRET}"
sh -c "nexmo sms --from=${NEXMO_NUMBER} ${TO_NUMBER} $* --confirm"