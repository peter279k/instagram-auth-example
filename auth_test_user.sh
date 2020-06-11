#!/bin/bash

app_id="app_id"
redirect_uri="https://peterli.website/auth/"

read -p 'Which browser? Please type firefox or google-chrome-stable: ' web_browser_name

if [[ ${web_browser_name} != "firefox" && ${web_browser_name} != "google-chrome-stable" ]]; then
    echo 'Please type firefox or google-chrome-stable'

    exit 1;
fi;

${web_browser_name} "https://api.instagram.com/oauth/authorize?client_id="${app_id}"&redirect_uri="${redirect_uri}"&scope=user_profile,user_media&response_type=code"
