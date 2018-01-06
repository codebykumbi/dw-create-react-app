# dw-create-react-app

Dockerfile for a docker workspace image. The entrypoint copies a pre-made create-react-app app into the working directory - particularly useful when the working directory is mounted to the host. Allows you to get developing on a create-react-app in no time! No need to wait for initial `npm install`, which can be rather annoying.

## Build or Pull

```
docker build -t dw-create-react-app:latest .
```

or 

```
docker pull codebykumbi/dw-create-react-app:latest
```

*See [link](https://hub.docker.com/r/codebykumbi/create-react-app/) for public docker image on DockerHub

*See [link](https://github.com/codebykumbi/workspace) for a convenient tool for starting docker workspaces.

## Usage

Running the command below creates an instance of the docker image and starts a bash terminal. It also copies `create-react-app` boiler player into `$PWD/myapp`. As per the volume mount logic, modifications to files in `$PWD/myapp` on the host are reflected to files in `/myapp` inside the container.

```
docker run --rm -it -v "$PWD/myapp":/myapp -w /myapp dw-create-react-app:latest bash
```

Running the `tree` in the resulting terminal (assuming the tree package is installed)

```bash
root@48871fabf221:/usr/src/myapp# tree
.
|-- README.md
|-- node_modules -> /tmp/src/myapp/node_modules
|-- node_modules.tar
|-- package.json
|-- public
|   |-- favicon.ico
|   |-- index.html
|   `-- manifest.json
|-- src
|   |-- App.css
|   |-- App.js
|   |-- App.test.js
|   |-- index.css
|   |-- index.js
|   |-- logo.svg
|   `-- registerServiceWorker.js
`-- yarn.lock

3 directories, 14 files

```

Notice how `./node_modules` is a symlink to a directory in the `tmp` folder. This allows us to leverage pre installed npm dependencies. It also means that the `node_modules` don't clutter the folder structure on your host and therefore there's less work for the volume mount.

Consult `./Dockerfile` and `./entrypoint.sh` in this repository for details regarding the
 target of the symlink.
