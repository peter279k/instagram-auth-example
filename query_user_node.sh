#!/bin/bash

access_token="access_token"
user_id="user_id"

curl -X GET \
  "https://graph.instagram.com/${user_id}?fields=id,username&access_token=${access_token}"

echo ""

curl -X GET \
  "https://graph.instagram.com/me?fields=id,username&access_token=${access_token}"
