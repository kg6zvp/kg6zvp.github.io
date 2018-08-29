---
layout: post
title: "Getting into Thorntail v4"
categories: java maven thorntail-v4
---

## What is Thorntail v4?

Thorntail v4 is in beta as of August 2018:

- Thorntail v4 is an open-source java framework
- Thorntail v4 is a java runtime for developing server-side applications
- Thorntail v4 is like Java EE
- Thorntail v4 is for building small, runnable jars from your projects
- Thorntail v4 is modular and composable
- Thorntail v4 is fast at starting and fast at serving requests
- Thorntail v4 is a complete re-write of Thorntail v2 (which is currently released) that provides greater speed and flexibility

## Why Thorntail v4?

If you want something event-driven, declarative and quick to learn for building scalable backends, Thorntail v4 is for you. It takes just a few minutes to build a server-side application with Thorntail v4 with a database, ReST API and anything else you can imagine.

Just a few of the great features you get with Thorntail v4 are:

- flexible runtime config through environment variables and other means with the ability to specify default values (great for Kubernetes)
- metrics gathering and reporting
- ability of application instances to report their own health (can be customized if desired)
- declarative ReST client
- fault tolerance tools
- testing tools
- asynchronous events
- support for SQL-based databases as well as others like Cassandra, CouchDB, Mongo and even Neo4j
- web frontend

## Getting Thorntail v4

Head over to my article on installing Thorntail v4 ([here](/java/maven/ci/thorntail-v4/2018/08/16/getting-ttv4.html)) to get it into your system's maven cache

## Using Thorntail v4

Unlike a typical JavaEE server, you shouldn't think of the runtime as actually being separate from your program. In Thorntail, whatever you add as a maven dependency is part of the runtime, much like a Java SE project. Indeed, Thorntail v4 is not fully JavaEE and should not be treated as such in project setup.

Thorntail is built up of components designed for a particular task. The following are examples of the components I use most frequently:

### Kernel

The very core of Thorntail transitively included in any Thorntail project. Comes with the following features:

- CDI
- CDI events (these classes can be found in the `io.thorntail.events.LifecycleEvent` class [here](https://github.com/thorntail/thorntail/blob/b8a5a3fdf7d315bb1f53266a931259fb64648e18/core/kernel/src/main/java/io/thorntail/events/LifecycleEvent.java))
- Microprofile-Config

### Jaxrs

Support for building declarative ReST APIs quickly and easily

### JPA

Support for building applications using Hibernate with a database that has a JDBC driver such as MySQL, MariaDB, H2, etc.

### OGM

Support for NoSQL databases with JPA like MongoDB, Apache Cassandra, CouchDB, Infinispan, Neo4j, etc. It's a fantastic project I recommend reading more about [here](http://hibernate.org/ogm/).

## Sample Project

Thorntail v4 comes with a simple project template you can generate a project from with the following command:

`$ mvn -B archetype:generate -DarchetypeGroupId=io.thorntail.archetypes -DarchetypeArtifactId=thorntail-jaxrs-archetype -DgroupId=com.example -DartifactId=sampleapp`

Let's break down the project maven just created for us:

```
$ tree sampleapp

sampleapp
├── pom.xml                                   # project descriptor
└── src
    ├── main                                  # application code
    │   ├── java
    │   │   └── com
    │   │       └── example
    │   │           ├── MyApplication.java    # main method as well as Jax-RS metadata for the base url of the ReST API
    │   │           └── MyResource.java       # the actual ReST API code
    │   └── resources                         # non-code project files
    │       └── META-INF                      # project metadata
    │           ├── application.properties    # default configuration values for our application
    │           └── beans.xml                 # required file, can be empty, more on this later
    └── test                                  # test code
        └── java
            └── com
                └── example
                    └── MyTest.java           # test code for the ReST API

11 directories, 6 files
```

### src/main/java/com/example/MyApplication.java

This file contains the Jax-RS `Application` class which configures the base url for the ReST API code. I'll be doing an article on building ReST APIs with Thorntail v4 shortly.

```java
package com.example;

import javax.ws.rs.ApplicationPath;
import javax.ws.rs.core.Application;

import io.thorntail.Thorntail;

@ApplicationPath("/") // sets the base url of the ReST API for this project to '/' because the entire project is a ReST API
public class MyApplication extends Application { // @ApplicationPath(String baseUrl) can only be used on classes which extend Application
    public static void main(String... args) throws Exception {
        Thorntail.run(); // runs Thorntail v4
    }
}
```

### src/main/java/com/example/MyResource.java

This is a Jax-RS "endpoint" class. It's `@Path`, or base url, is appended to the base url for the Jax-RS `Application` class, `MyApplication` in this project. It is a plain Java class and doesn't need to be of any particular type. This class contains java methods corresponding to a specific url and/or specific HTTP method.

```java
package com.example;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

@Path("/") // sets the base url for this class relative to the base url of the ReST API project
public class MyResource {
    @GET // tells the router to invoke this method for HTTP GET requests
    @Produces(MediaType.TEXT_PLAIN) // sets the mime type of the data to be returned to 'text/plain'
    public String hello() { // Instead of managing the request router yourself, you just set the return type to whatever you want and the rest is automatic
        return "Hello World"; // No magic, just return a String and you're done
    }
}
```

### src/main/resources/META-INF/application.properties

This file contains defaults for configuration data. If you wished to override the configuration at runtime, you could pass `-Dlogging.level.io.undertow=$some_value` at runtime.

```
#logging.level.io.undertow=ALL
```

### src/main/resources/META-INF/beans.xml

This file is empty, but it's there to enable dependency injection with CDI inside java classes. Just trust me that you don't want to disable dependency injection. It is your friend.

### src/test/java/com/example/MyTest.java 

This file contains an integration test which checks that the application creates a ReST API which returns "Hello World" from the root of the web server.

```java
package com.example;

import io.thorntail.test.ThorntailTestRunner;
import org.junit.Test;
import org.junit.runner.RunWith;

import static io.restassured.RestAssured.when;
import static org.hamcrest.Matchers.containsString;

@RunWith(ThorntailTestRunner.class) // Integration tests should be run with the ThorntailTestRunner class to be run in the container
public class MyTest {

    @Test
    public void test() {
        when().get("/").then() // When an HTTP GET is invoked on the '/' url
                .statusCode(200) // assert that the server returns a 200 OK as the response status
                .body(containsString("Hello World")); // assert the body contains the string "Hello World"
    }
}
```

This class does something very similar to Arquillian, but without the isolation between the app and the test and without requiring the definition of a deployment. It runs the tests with the whole app loaded so the test environment is as close to production as you can get.

## Keep Going

Now that you've setup a basic project and learned how it works, you're ready to explore Thorntail v4 in more detail.
