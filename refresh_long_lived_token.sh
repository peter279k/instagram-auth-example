#!/bin/bash

expired_long_lived_access_token="expired_long_lived_access_token"

curl -i -X GET "https://graph.instagram.com/refresh_access_token?grant_type=ig_refresh_token&access_token=${expired_long_lived_access_token}"
