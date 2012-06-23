
# Better curl(1)

  `burl(1)` is a tiny shell script augmenting `curl(1)` with some helpful shortcuts.

## Installation

    $ make install

## Optional hostname

 By default `burl(1)` will assume "http://localhost:3000", however you
 can alter this by exporting `BURL` in your terminal session or `.profile`:

```
$ export BURL=http://site-im-testing.com
$ burl /pathname
```

## -j, --json DATA

  __POST__ data as "Content-Type: application/json":
  
```
$ burl -j {"name":"tobi"} /user
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
