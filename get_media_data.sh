#!/bin/bash

user_id="me/media/"
access_token="access_token"

curl -X GET \
    "https://graph.instagram.com/${user_id}?fields=id,media_type,media_url,username,timestamp&access_token=${access_token}"
