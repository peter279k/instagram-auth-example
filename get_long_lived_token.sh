#!/bin/bash

app_secret="app_secret"
short_lived_access_token="short_lived_access_token"

# If letting cURL present response headers, remove -i option

curl -i -X GET "https://graph.instagram.com/access_token?grant_type=ig_exchange_token&client_secret=${app_secret}&access_token=${short_lived_access_token}"
