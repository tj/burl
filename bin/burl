#!/usr/bin/env bash

version="1.0.1"
debug=
args="-s"
BURL=${BURL:-http://localhost:3000}
quote="[[:space:]]|[&<>;]"

#
# output usage
#

usage() {
  cat <<EOF

  Usage: burl [options] <url>

  Options:

    -j, --json <data>    issue an application/json request
    -u, --update         update burl from the git repository
    --burl-version       output burl(1) version

  Examples:

    $ burl /users
    $ burl /users .json
    $ burl /users .text
    $ burl /users .html
    $ burl /search?query=foo
    $ burl Accept: application/json /users
    $ burl If-None-Match: etag /users
    $ burl GET /users If-None-Match: etag
    $ burl -X GET --json '{"query":"something"}' /search
    $ burl PATCH '{"name":"tobi"}' /user/12
    $ burl POST [1,2,3] /numbers
    $ burl POST @body.json /

  Environment:

    $ export BURL=http://site-im-testing.com
    $ burl /pathname

EOF
}

#
# update burl(1)
#

update() {
  local orig=$PWD

  cd /tmp \
    && rm -fr ./burl \
    && git clone --depth 1 https://github.com/visionmedia/burl.git \
    && cd burl \
    && make install \
    && cd "$orig" \
    && echo "... updated burl $version -> $(burl --burl-version)"
}

# parse args

while test $# -ne 0; do
  arg=$1; shift
  case $arg in
    --debug)
      debug=1
      ;;
    --pretty)
      pretty=1
      ;;
    -j|--json)
      json=$1; shift
      args="$args -H 'Content-Type: application/json' -d '$json'"
      ;;
    -c|-b)
      cookie=$1; shift
      args="$args $arg $cookie"
      ;;
    GET|POST|PUT|HEAD|DELETE|OPTIONS|PATCH|TRACE|COPY|LOCK|\
    MKCOL|MOVE|PROPFIND|PROPPATCH|UNLOCK|REPORT|MKACTIVITY|\
    CHECKOUT|MERGE|NOTIFY|SUBSCRIBE|UNSUBSCRIBE)
      args="$args -X $arg"
      c=${1:0:1}

      # json array
      if test "$c" = "["; then
        args="$args -d \"$1\" -H \"Content-Type: application/json\""
        shift
      fi

      # json object
      if test "$c" = "{"; then
        args="$args -d \"$1\" -H \"Content-Type: application/json\""
        shift
      fi

      # @json file
      if test "$c" = "@"; then
        args="$args --data $1 -H \"Content-Type: application/json\""
        shift
      fi
      ;;
    *:)
      val=$1; shift
      args="$args -H \"$arg $val\""
      ;;
    /*)
      args="$args '$BURL$arg'"
      ;;
    .html)
      args="$args -H Accept:text/html"
      ;;
    .txt|.text)
      args="$args -H Accept:text/plain"
      ;;
    .json)
      args="$args -H Accept:application/json"
      ;;
    --burl-version)
      echo $version
      exit
      ;;
    -h|--help)
      usage
      exit
      ;;
    -u|--update)
      update
      exit
      ;;
    *)
      if [[ $arg =~ $quote ]]; then
        args="$args \"$arg\""
      else
        args="$args $arg"
      fi
      ;;
  esac
done

test $pretty && args="$args | python -mjson.tool"
test $debug && echo "curl $args"
eval "curl $args"
