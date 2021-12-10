# Earthly Auto Build Repo

> This repo contains the Earthfile of some useful images under the Docker Hub [`mritd`](https://hub.docker.com/u/mritd) user.


| Status | Docker Hub |
|-------|------------|
|[![mritd/alpine](https://github.com/mritd/autobuild/actions/workflows/alpine.yaml/badge.svg)](https://github.com/mritd/autobuild/actions/workflows/alpine.yaml)|[https://hub.docker.com/repository/docker/mritd/alpine](https://hub.docker.com/repository/docker/mritd/alpine)|
|[![mritd/caddy](https://github.com/mritd/autobuild/actions/workflows/caddy.yaml/badge.svg)](https://github.com/mritd/autobuild/actions/workflows/caddy.yaml)|[https://hub.docker.com/repository/docker/mritd/caddy](https://hub.docker.com/repository/docker/mritd/caddy)|
|[![mritd/certmonitor](https://github.com/mritd/autobuild/actions/workflows/certmonitor.yaml/badge.svg)](https://github.com/mritd/autobuild/actions/workflows/certmonitor.yaml)|[https://hub.docker.com/repository/docker/mritd/certmonitor](https://hub.docker.com/repository/docker/mritd/certmonitor)|
|[![mritd/confluence](https://github.com/mritd/autobuild/actions/workflows/confluence.yaml/badge.svg)](https://github.com/mritd/autobuild/actions/workflows/confluence.yaml)|[https://hub.docker.com/repository/docker/mritd/confluence](https://hub.docker.com/repository/docker/mritd/confluence)|
|[![mritd/ddns](https://github.com/mritd/autobuild/actions/workflows/ddns.yaml/badge.svg)](https://github.com/mritd/autobuild/actions/workflows/ddns.yaml)|[https://hub.docker.com/repository/docker/mritd/ddns](https://hub.docker.com/repository/docker/mritd/ddns)|
|[![mritd/demo](https://github.com/mritd/autobuild/actions/workflows/demo.yaml/badge.svg)](https://github.com/mritd/autobuild/actions/workflows/demo.yaml)|[https://hub.docker.com/repository/docker/mritd/demo](https://hub.docker.com/repository/docker/mritd/demo)|
|[![mritd/idgen](https://github.com/mritd/autobuild/actions/workflows/idgen.yaml/badge.svg)](https://github.com/mritd/autobuild/actions/workflows/idgen.yaml)|[https://hub.docker.com/repository/docker/mritd/idgen](https://hub.docker.com/repository/docker/mritd/idgen)|
|[![mritd/jira](https://github.com/mritd/autobuild/actions/workflows/jira.yaml/badge.svg)](https://github.com/mritd/autobuild/actions/workflows/jira.yaml)|[https://hub.docker.com/repository/docker/mritd/jira](https://hub.docker.com/repository/docker/mritd/jira)|
|[![mritd/nginx-singlepage](https://github.com/mritd/autobuild/actions/workflows/nginx-singlepage.yaml/badge.svg)](https://github.com/mritd/autobuild/actions/workflows/nginx-singlepage.yaml)|[https://hub.docker.com/repository/docker/mritd/nginx-singlepage](https://hub.docker.com/repository/docker/mritd/nginx-singlepage)|
|[![mritd/nodebuild](https://github.com/mritd/autobuild/actions/workflows/nodebuild.yaml/badge.svg)](https://github.com/mritd/autobuild/actions/workflows/nodebuild.yaml)|[https://hub.docker.com/repository/docker/mritd/nodebuild](https://hub.docker.com/repository/docker/mritd/nodebuild)|
|[![mritd/openjdk](https://github.com/mritd/autobuild/actions/workflows/openjdk.yaml/badge.svg)](https://github.com/mritd/autobuild/actions/workflows/openjdk.yaml)|[https://hub.docker.com/repository/docker/mritd/openjdk](https://hub.docker.com/repository/docker/mritd/openjdk)|
|[![mritd/poetbot](https://github.com/mritd/autobuild/actions/workflows/poetbot.yaml/badge.svg)](https://github.com/mritd/autobuild/actions/workflows/poetbot.yaml)|[https://hub.docker.com/repository/docker/mritd/poetbot](https://hub.docker.com/repository/docker/mritd/poetbot)|
|[![mritd/privoxy](https://github.com/mritd/autobuild/actions/workflows/privoxy.yaml/badge.svg)](https://github.com/mritd/autobuild/actions/workflows/privoxy.yaml)|[https://hub.docker.com/repository/docker/mritd/privoxy](https://hub.docker.com/repository/docker/mritd/privoxy)|
|[![mritd/s2h](https://github.com/mritd/autobuild/actions/workflows/s2h.yaml/badge.svg)](https://github.com/mritd/autobuild/actions/workflows/s2h.yaml)|[https://hub.docker.com/repository/docker/mritd/s2h](https://hub.docker.com/repository/docker/mritd/s2h)|
|[![mritd/ssh](https://github.com/mritd/autobuild/actions/workflows/ssh.yaml/badge.svg)](https://github.com/mritd/autobuild/actions/workflows/ssh.yaml)|[https://hub.docker.com/repository/docker/mritd/ssh](https://hub.docker.com/repository/docker/mritd/ssh)|
|[![mritd/docker-cli](https://github.com/mritd/autobuild/actions/workflows/docker-cli.yaml/badge.svg)](https://github.com/mritd/autobuild/actions/workflows/docker-cli.yaml)|[https://hub.docker.com/repository/docker/mritd/docker-cli](https://hub.docker.com/repository/docker/mritd/docker-cli)|



## Why not use Dockerfile?

In the past few years, I have to admit that Dockerfile is great; but as the number of Dockerfile increases, I have to do a lot of repetitive work to solve some problems.

For example, "unify the basic image version"、"fix compatibility issues for specific languages"、"cross compile for each platform", etc...

Well, I can write some "magic scripts" to be lazy; but this will cause the production-level Docker image to become unmaintainable, just like a messy network cable...

Now, Earthly has solved this problem; I unified the specific language version、the operating system at compile time、the basic runtime environment、and some general fixes. Also use GitHub Action for reliable cross-compilation to generate multi-arch images. It all got better 🤪.


## Directory Structure

```sh
.
├── earthfiles                      # All Earthfiles are contained in this directory
│   ├── alpine
│   │   ├── build.sh
│   │   └── Earthfile
│   ├── caddy                       # The second-level directory name is the target image
│   │   ├── build.sh
│   │   ├── Earthfile
│   │   └── version
│   ├── openjdk
│   │   ├── build.sh                # Every image directory will have `build.sh` for automated build
│   │   ├── cgradle                 # If the build image needs some other files, they will also be saved in this directory
│   │   ├── cmvn
│   │   └── Earthfile               # Earthfile is a file similar to Dockerfile, it is modular, it is very convenient to reuse code
│   │
│   │
│   └── udcs                        # udcs (user-defined commands) is a special directory where most common Earthfiles are stored
│       ├── Earthfile               # udcs/Earthfile stores general commands that do not depend on system os and language
│       ├── image                   # udcs/image stores the basic runtime or compile image of most programming languages
│       ├── language                # udcs/language stores special commands for specific languages
│       └── os                      # udcs/os stores special commands for specific system os
│
│
├── .github
│   └── workflows                   # The workflows directory stores job definitions for each docker image automated build
│       ├── alpine.yaml
│       ├── caddy.yaml
│       ├── certmonitor.yaml
│       ├── confluence.yaml
│       ├── ddns.yaml
│       ├── demo.yaml
│       ├── idgen.yaml
│       ├── jira.yaml
│       ├── nginx-singlepage.yaml
│       ├── nodebuild.yaml
│       ├── openjdk.yaml
│       ├── poetbot.yaml
│       ├── privoxy.yaml
│       ├── s2h.yaml
│       └── ssh.yaml
└── LICENSE
```
