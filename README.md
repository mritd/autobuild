# Earthly Auto Build Repo

> This repo contains the Earthfile of some useful images under the Docker Hub [`mritd`](https://hub.docker.com/u/mritd) user.


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
