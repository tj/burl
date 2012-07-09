
# Better curl(1)

  `burl(1)` is a tiny shell script augmenting `curl(1)` with some helpful shortcuts.

## Installation

    $ make install

## Optional hostname

 By default `burl(1)` will assume "http://localhost:3000", however you
 can alter this default by exporting `BURL` in your terminal session or `.profile`:

```
$ export BURL=http://site-im-testing.com
$ burl /pathname
```

 Or like usual you can specify a full url:

```
$ burl http://google.com
```

## -j, --json DATA

  __POST__ data as "Content-Type: application/json":
  
```
$ burl -j {"name":"tobi"} /user
```

## HTTP verbs

  Instead of the typical `-X DELETE` verb usage with `curl(1)`, you may use
  the verbs directly, for example:

```
$ burl PATCH -d 'email=tobi@learnboost.com' /user/12
$ burl DELETE /users
```

## JSON request bodies

 Usually when you want to request with some JSON you do something like:

```
$ curl -X PATCH -d '{"name":"tobi"}' -H "Content-Type: application/json" http://localhost:3000/user/12
```

 With `burl(1)` you can simply add a JSON array or object after the HTTP verb:

```
$ burl PATCH '{"name":"tobi"}' /user/12
$ burl POST [1,2,3] /numbers
```


## Expressive header fields

  With `burl(1)` you can define header fields without `-H`:

```
$ burl If-None-Match: etag /users
$ burl If-None-Match: etag Accept: application/json /users
```

## Accept shorthand

  Currently `.json`, `.text` and `.html` shorthands are
  available and set the Accept header field for you:

```
$ burl /users
$ burl /users .json
$ burl /users .text
$ burl /users .html
```

## Extras

  * Added support for prettyjson. It needs python and json.tool module.

## Aliases

  Try these aliases if you want to get fancy:

```
alias GET='burl GET'
alias HEAD='burl -I'
alias POST='burl POST'
alias PUT='burl PUT'
alias PATCH='burl PATCH'
alias DELETE='burl DELETE'
alias OPTIONS='burl OPTIONS'
```
