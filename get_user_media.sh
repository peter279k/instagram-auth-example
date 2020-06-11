#!/bin/bash

access_token="access_token"

curl -X GET \
    "https://graph.instagram.com/me/media?fields=id,caption&access_token=${access_token}"
