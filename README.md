# instagram-auth-example
This is the Instagram authentication example scripts

# Instagram Authentication Steps

## Authenticate the test user
- Before starting following steps, please refer this [Gist link](https://gist.github.com/peter279k/1c3ed14473b8055057d0213d759e92ed).
- We assume that you've registered Facebook App ID and enable the completed Instagram Basic Display ID features.
- Please refer and run [auth_test_user.sh](auth_test_user.sh).

![alt_img](https://imgur.com/dlPVfqo.png)

![alt_img](https://i.imgur.com/p41j2B4.png)

```Bash
#!/bin/bash

app_id="instagram_app_id"
redirect_uri="oauth_instagram_redirect_url"

firefox "https://api.instagram.com/oauth/authorize?client_id="${app_id}"&redirect_uri="${redirect_uri}"&scope=user_profile,user_media&response_type=code"

# It will get authorization codes

# https://oauth_instagram_redirect_url.website/auth/?code={your_authorization_code}#_

# Copy above url with code param value without "#_" character

```

## Exchange code for the token

- Please refer and run [exchange_code_for_token.sh](exchange_code_for_token.sh).

```Bash
#!/bin/bash

code="authorization_code"
app_id="instagram_app_id"
app_secret="instagram_app_secret"

# oauth_instagram_redirect_url will be same as previous redirect_uri during auth_test_user.sh running!
redirect_uri="oauth_instagram_redirect_url"

curl -X POST \
  https://api.instagram.com/oauth/access_token \
  -F client_id=${app_id} \
  -F client_secret=${app_secret} \
  -F grant_type=authorization_code \
  -F redirect_uri=${redirect_uri} \
  -F code=${code}

```

- The sample response will be as follows:

```JSON
{"access_token": "short_lived_access_token", "user_id": "user_id"}
```

##  Query the User Node

- Query the user node via above access token

```Bash
#!/bin/bash

access_token="above_access_token"
user_id="user_id"

curl -X GET \
  "https://graph.instagram.com/${user_id}?fields=id,username&access_token=${access_token}"

echo ""

curl -X GET \
  "https://graph.instagram.com/me?fields=id,username&access_token=${access_token}"

```

- The sample response is as follows:

```JSON
{"id":"instagram_user_id","username":"instagram_user_name"}
```

## Get a Long-Lived Token

- There're two ways to get a Long-Lived Token:
  - Using Token Generator

![alt_img](https://imgur.com/d2vumwZ.png)

  - Using the following Bash script. Refer [get_long_lived_token.sh](get_long_lived_token.sh)

```Bash
#!/bin/bash

app_secret="instagram_app_secret"
short_lived_access_token="short_lived_access_token"

# If letting cURL present response headers, remove -i option

curl -i -X GET "https://graph.instagram.com/access_token?grant_type=ig_exchange_token&client_secret=${app_secret}&access_token=${short_lived_access_token}"

```

- The sample response is as follows:

```JSON
{"access_token":"long_lived_access_token","token_type":"bearer","expires_in":5184000}
```

## Refresh a Long-Lived Token

- Using following Bash script and refer [refresh_long_lived_token.sh](refresh_long_lived_token.sh)

```Bash
#!/bin/bash

expired_long_lived_access_token="expired_long_lived_access_token"

curl -i -X GET "https://graph.instagram.com/refresh_access_token?grant_type=ig_refresh_token&access_token=${expired_long_lived_access_token}"
```

- The sample response is as follows:

```JSON
{"access_token":"long_lived_access_token","token_type":"bearer","expires_in":5183449}
```

## Get User Profiles and User Media

### Get a User’s Media

- Using following Bash script and refer [get_user_media.sh](get_user_media.sh)

```Bash
#!/bin/bash

access_token="access_token"

curl -X GET \
    "https://graph.instagram.com/me/media?fields=id,caption&access_token=${access_token}"
```

- Default limit data is `25` and it can set `limit` param on request URL to set limit data number. (max limit data number is `80`)
- The sample response is as follows:

```JSON
{
  "data": [
    {
      "id": "18137050651011961"
    },
    {
      "id": "17871491986635679"
    },
    {
      "id": "17946792001336274",
      "caption": "#紅葉國小"
    },
    {
      "id": "17890427956485428"
    },
    {
      "id": "17895048049463316"
    },
    {
      "id": "17856103459887624",
      "caption": "#鹿野"
    },
    {
      "id": "17901981256453805"
    },
    {
      "id": "17885941990521309",
      "caption": "#鯉魚山"
    },
    {
      "id": "17882981587530952"
    },
    {
      "id": "17844567542071793"
    },
    {
      "id": "18122891203079538"
    },
    {
      "id": "18082696999170900"
    },
    {
      "id": "17859966562790929"
    },
    {
      "id": "17842574663067799",
      "caption": "#墨洋拉麵"
    },
    {
      "id": "17854845658827440"
    },
    {
      "id": "18092942026193855"
    },
    {
      "id": "17854438720851186",
      "caption": "#老地方觀機平台"
    },
    {
      "id": "18132065770021334",
      "caption": "#豚骨咖哩飯"
    },
    {
      "id": "18128504467030119",
      "caption": "#starbucks\n#meetwithfriends"
    },
    {
      "id": "17993536255286565",
      "caption": "#蚵爹之家"
    },
    {
      "id": "18101814856103420",
      "caption": "#沙溪堡\n#沙溪坑道"
    },
    {
      "id": "17858814256703410"
    },
    {
      "id": "17883320632488803",
      "caption": "#芋頭冰"
    },
    {
      "id": "17844005662909075"
    },
    {
      "id": "17853219847770998",
      "caption": "#擎天廳"
    }
  ],
  "paging": {
    "cursors": {
      "before": "{before_token_param}",
      "after": "{after_token_param}"
    },
    "next": "https://graph.instagram.com/v1.0/{user_id}/media?access_token={access_token}&fields=id%2Ccaption&limit=25&after={after_token_param}"
  }
}
```

### Get Media Data

- Default limit data is `25` and it can set `limit` param on request URL to set limit data number. (max limit data number is `80`)
- Using following Bash script or refer [get_media_data.sh](get_media_data.sh).

```Bash
#!/bin/bash

user_id="me/media/"
access_token="access_token"

curl -X GET \
    "https://graph.instagram.com/${user_id}?fields=id,media_type,media_url,username,timestamp&access_token=${access_token}"

```

- The sample response is as follows:

```JSON
{
  "data": [
    {
      "id": "17861912218925283",
      "media_type": "CAROUSEL_ALBUM",
      "media_url": "https://scontent.cdninstagram.com/v/t51.2885-15/103047977_1158542857846565_1367304746422318254_n.jpg?_nc_cat=111&_nc_sid=8ae9d6&_nc_ohc=OosReTDky7kAX-ULx3g&_nc_ht=scontent.cdninstagram.com&oh=ba2a1113bc5f32979601d669c4686966&oe=5F06B686",
      "username": "peter279k",
      "timestamp": "2020-06-11T17:36:09+0000"
    },
    {
      "id": "17871491986635679",
      "media_type": "IMAGE",
      "media_url": "https://scontent.cdninstagram.com/v/t51.2885-15/91465033_259754968372982_409755531119174105_n.jpg?_nc_cat=109&_nc_sid=8ae9d6&_nc_ohc=OzXwCakgkGQAX-q_2CT&_nc_ht=scontent.cdninstagram.com&oh=1b791abbe3ba0d33133154ea29d0f311&oe=5F08B40C",
      "username": "peter279k",
      "timestamp": "2020-04-02T07:23:44+0000"
    },
    {
      "id": "17946792001336274",
      "media_type": "IMAGE",
      "media_url": "https://scontent.cdninstagram.com/v/t51.2885-15/91612257_2971857936197919_702226242484782862_n.jpg?_nc_cat=104&_nc_sid=8ae9d6&_nc_ohc=fHZge7GictoAX-t2MDA&_nc_ht=scontent.cdninstagram.com&oh=7def588e6aa2d9639a8978ed2aa8ca54&oe=5F0764CB",
      "username": "peter279k",
      "timestamp": "2020-04-02T05:57:40+0000"
    },
    ......
  ],
  "paging": {
    "cursors": {
      "before": "{before_token_param}",
      "after": "{after_token_param}"
    },
    "next": "https://graph.instagram.com/v1.0/17841403128568296/media?access_token={access_token}&fields=id%2Cmedia_type%2Cmedia_url%2Cusername%2Ctimestamp&limit=25&after={after_token_param}"
  }
}
```

## Get Album Contents

- Perform the following steps to get a collection of image and video Media on an album Media.
- Default limit data is `25` and it can set `limit` param on request URL to set limit data number. (max limit data number is `80`)
- Using following Bash script or refer [get_album_contents.sh](get_album_contents.sh).

```Bash
#!/bin/bash

media_id="media_id"
access_token="access_token"

curl -X GET \
    "https://graph.instagram.com/${media_id}/children?fields=id,media_type,media_url,username,timestamp&access_token=${access_token}"

```

- The sample response is as follows:

```JSON
{
  "data": [
    {
      "id": "18121908406106194",
      "media_type": "IMAGE",
      "media_url": "https://scontent.cdninstagram.com/v/t51.2885-15/103047977_1158542857846565_1367304746422318254_n.jpg?_nc_cat=111&_nc_sid=8ae9d6&_nc_ohc=OosReTDky7kAX-ULx3g&_nc_ht=scontent.cdninstagram.com&oh=ba2a1113bc5f32979601d669c4686966&oe=5F06B686",
      "username": "peter279k",
      "timestamp": "2020-06-11T17:36:09+0000"
    },
    {
      "id": "17926691989391970",
      "media_type": "IMAGE",
      "media_url": "https://scontent.cdninstagram.com/v/t51.2885-15/102912714_285788732472357_2321417626557789464_n.jpg?_nc_cat=107&_nc_sid=8ae9d6&_nc_ohc=RhmG6Wel9_gAX_vHOBx&_nc_ht=scontent.cdninstagram.com&oh=8372fdb10bc80724ca4fcbaa4a4efa62&oe=5F08CD26",
      "username": "peter279k",
      "timestamp": "2020-06-11T17:36:09+0000"
    },
    ......
  ]
}
```
