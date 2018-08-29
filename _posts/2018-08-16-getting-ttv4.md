---
layout: post
title: "Get Thorntail v4"
icon: fa-file-download
categories: java maven ci thorntail-v4
permalink: /blog/2018/08/16/getting-ttv4.html
---

Thorntail v4 hasn't been released yet, but that doesn't mean it's too early to start using it in your projects. It's even easier than you think to get it.

For those of you who don't know, Thorntail v4 is a complete re-write of Thorntail v2 (formerly known as Wildfly Swarm: [http://wildfly-swarm.io/](http://wildfly-swarm.io/)) and is an amazing platform for building server-side Java applications on.

## Building Thorntail v4

You need the following:

- Linux, BSD or Mac OS X (also works on Windows, but I don't have a batch script for it or a way to test)
- Maven 3.25+
- Java 8 JDK
- Git

I've been using Thorntail v4 for awhile, so I made a script which runs on CI to grab the latest v4 and install it into the local maven cache.

```bash
#!/bin/bash

#apk update && apk add openssl ca-certificates git # uncomment if you're using the maven:alpine image
git clone 'https://github.com/thorntail/thorntail'> /dev/null
cd thorntail/ && git checkout 4.x
# git checkout $COMMIT_HASH # uncomment this line if you want to lock CI down to a specific commit hash
mvn -DskipDocker -DskipTests install -pl '!docs,!howto/openshift,!howto/openshift-s2i'
cd .. && rm -rf thorntail
```

Run that script and you are ready to start using Thorntail v4 in your projects!