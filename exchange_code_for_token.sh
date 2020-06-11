#!/bin/bash

code="authorization_code"
app_id="app_id"
app_secret="app_secret"
redirect_uri="https://peterli.website/auth/"

curl -X POST \
  https://api.instagram.com/oauth/access_token \
  -F client_id=${app_id} \
  -F client_secret=${app_secret} \
  -F grant_type=authorization_code \
  -F redirect_uri=${redirect_uri} \
  -F code=${code}
