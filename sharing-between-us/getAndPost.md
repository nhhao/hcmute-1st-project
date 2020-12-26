# Project 1 with Phu

```json
//Post an article
{
	'_id': 0, //optional
	'title': 'How to write that',
	'description': 'some text...',
	'content': 'some text lorem...',
	'category': 'back-end',
	'datetime': 'today', //optional
	'author': 'nhathao',
	'upVote': 0, //optional
	'downVote': 0, //optional
	'url': 'url', //optional
	'thumbnailUrl': 'thumbnailUrl'
}
```

```json
//Post a comment
{
	'_id': 1;
	'username': 'dinhphu',
	'content': 'some comment',
	'datetime': 'today', //optional
}
```

```json
//Get all articles
{
	'pageNumber': 1,
	'category': 'android'
}

// 'category': {'default', 'back-end', 'front-end', 'android', 'ios', 'tips-tricks'}
```

```json
//Get all comments
{
	'_id': 12,
}
```

```json
//Post an upVote/ a downVote
{
	'_id': 2,
	'username': 'someone',
	'isUpButtonClicked': true,
	'isDownButtonClicked': false,
}

//Get vote status for current user
{
	'_id': 3,
	'username': 'someone'
}
//Response should be
{
	'isUpButtonClicked': true,
	'isDownButtonClicked': false,
}
```

### User

```json
//Post a login request
{
	'username': 'something',
	'password': 'something-more',
	'role': 1,
}
// role: | 1 is normal | 2 is moderator 

//Response should be
{
	'isLoggedIn': true,
}
```

```json
//Post a sign up request

//When user typing on username field
{
	'currentUsername': 'dinhph',
}

//Response should be
{
	'isNotExisted': true,
}

//When create account button clicked
{
	'username': 'dinhphu',
	'password': 'pAssw0rd',
}
```

```json
//Post a user avatar
{
	'username': 'dinhphu',
	'avatarUrl': 'a-link'
}
```

``` Json
//Get an user avatar
{
    'username': 
}
// Response should be
{
    'avatarUrl': 'a-link'
}
```



### Admin

```json
//Get all moderators
{
}
//Response should be
{
	'moderators': [
		{
			'username': 'modphu',
			'displayName': 'Nguyen Dinh Phu',
			'avatarUrl': 'a-link',
		},
		{
			'username': 'modhao',
			'displayName': 'Nguyen Nhat Hao',
			'avatarUrl': 'another-link'
		},
	]
}
```

```json
//Create a moderator
{
	'username': 'dinhphu',
	'displayName': 'Nguyen Dinh Phu 2',
	'password': '1',
}
```

```json
//Kick out some moderator
{
	'username': 'someone',
}
```

```json
//response of List all moderator
{
    'moderators': [
        'username': 'meomeo',
        'username': 'catcat'
    ]
}
```

