#!/bin/sh

if [ ! -z "$(ls -A .)" ]; then
    echo "The working directory must be empty"
    exit 1
fi

## In working directory, copy boilerplate, create node_modules tar ball and create node_modules symlink
cp -a /tmp/src/myapp/. .
tar -xf node_modules.tar -C /tmp/src/myapp
ln -s /tmp/src/myapp/node_modules ./node_modules

# Hand off to the CMD
exec "$@"
