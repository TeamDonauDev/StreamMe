# StreamMe

## Project Name

Project ID: 61fbddf04ca11fd9cf40

## Package Name

name = de.teamdonaudev.streamme

## Testuser

- TestAdmin admin@admin.de adminadmin
- TestUser user@user.de useruser

## Collection Setup

```
{
    "$id": "61fbdfde4caa51aa6bae",
    "$read": [],
    "$write": [],
    "name": "Events",
    "enabled": true,
    "permission": "document",
    "attributes": [
        {
            "key": "name",
            "type": "string",
            "status": "available",
            "required": true,
            "array": false,
            "size": 255,
            "default": null
        },
        {
            "key": "gameTypes",
            "type": "string",
            "status": "available",
            "required": true,
            "array": true,
            "elements": [
                "CS_GO",
                "LEAGUE_OF_LEGENDS",
                "ROCKET_LEAGUE"
            ],
            "format": "enum",
            "default": null
        },
        {
            "key": "description",
            "type": "string",
            "status": "available",
            "required": true,
            "array": false,
            "size": 255,
            "default": null
        },
        {
            "key": "pubDateUTC",
            "type": "integer",
            "status": "available",
            "required": true,
            "array": false,
            "min": -9223372036854776000,
            "max": 9223372036854776000,
            "default": null
        },
        {
            "key": "stuffDeadlineUTC",
            "type": "integer",
            "status": "available",
            "required": true,
            "array": false,
            "min": -9223372036854776000,
            "max": 9223372036854776000,
            "default": null
        },
        {
            "key": "isPublic",
            "type": "boolean",
            "status": "available",
            "required": false,
            "array": false,
            "default": false
        }
    ],
    "indexes": []
}
```
