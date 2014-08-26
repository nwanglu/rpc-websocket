#!/usr/bin/env sh

# RPC Websocket
# Written by Erik Poupaert, Cambodia
# (c) 2014
# Licensed under the LGPL

## add web support

browserify lib/rpc-socket.js -o browser-support/rpc-websocket-bundle.js
uglifyjs browser-support/rpc-websocket-bundle.js -o browser-support/rpc-websocket-bundle.min.js

## build API documentation

markdox lib/rpc-socket.js -o doc/api/rpc-socket.draft.md
markdox lib/rpc-server.js -o doc/api/rpc-server.draft.md

## fix the headings

sed -e 's/^### Params:/_Params_/' -e 's/^##[^#]/#### /'  doc/api/rpc-socket.draft.md > \
       doc/api/rpc-socket.md
rm -f doc/api/rpc-socket.draft.md

sed -e 's/^### Params:/_Params_/' -e 's/^##[^#]/#### /' doc/api/rpc-server.draft.md > \
       doc/api/rpc-server.md
rm -f doc/api/rpc-server.draft.md

## create first draft of README.md

for f in $(ls doc/readme/*.md); do
        cat $f >> README.draft.1.md
done

## add external files

markdown-pp.py README.draft.1.md README.draft.2.md
rm -f README.draft.1.md

## replace ../index.js and ../../index.js by rpc-websocket

sed -e 's/\.\.\/\.\.\/index.js/rpc-websocket/' \
        -e 's/\.\.\/index.js/rpc-websocket/' README.draft.2.md > \
       README.md
rm -f README.draft.2.md

