#!/bin/bash

media_id="media_id"
access_token="access_token"

curl -X GET \
    "https://graph.instagram.com/${media_id}/children?fields=id,media_type,media_url,username,timestamp&access_token=${access_token}"
