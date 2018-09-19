---
layout: post
title: "Sudden DAO 1.0.0 released"
categories: java jpa
permalink: /blog/2018/09/18/sudden-dao-1.0.0.html
---

Today I released [Sudden DAO 1.0.0](https://github.com/kg6zvp/sudden-dao/) on Maven Central. It's a library I've been using on my own in other projects for a long time and felt it was time to release it to the world and begin working on more features for it.

## Why Sudden DAO?

In order to cleanly separate concerns between components, it's handy to have a _Database Access Object_ in a project that contains all of the operations needed to interface with the database. Sudden DAO not only contains Create, Read, Update and Delete operations, but some handy extras for projects like a matching method which performs a dynamic query of the database to match a given object.

For example, let's say I have a set of filters on a web page or mobile app and want to filter search results with them. All you have to do is pass a java object with the fields set to the values you want to filter by and it will return a list of similar objects ignoring the null fields.

## Where to get it?

Maven:

```xml
<dependency>
	<groupId>es.eisig</groupId>
	<artifactId>sudden-dao</artifactId>
	<version>1.0.0</version>
</dependency>
```

Gradle:

```groovy
repositories {
	mavenCentral()
}

dependencies {
	implementation 'es.eisig:sudden-dao:1.0.0'
}
```

## More Information

Check out the GitHub page for more examples and maven/gradle coordinates: [Sudden DAO](https://github.com/kg6zvp/sudden-dao/)
