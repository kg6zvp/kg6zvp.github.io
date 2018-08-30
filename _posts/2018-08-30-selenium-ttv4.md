---
layout: post
title: "Selenium Testing on Thorntail v4"
categories: java maven thorntail-v4 testing selenium
permalink: /blog/2018/08/30/selenium-testing-ttv4.html
---

# What is Selenium?

Selenium is a browser automation system offering the ability to control many different web browsers on different platforms.

# Why Selenium?

Testing is an important part of any software project. We've all seen the pyramid with unit tests and integration tests. When it comes to ensuring functionality in the web frontend, javascript tests only take you so far and you need some way of making sure that button really disappears when clicked, etc.

# Add Testing

## Get a starter project

// clone repo

## Add Selenium

Add selenium to your maven project's dependencies with the following xml snippet:

```xml
		<dependency>
			<groupId>org.seleniumhq.selenium</groupId>
			<artifactId>selenium-java</artifactId>
			<version>3.12.0</version>
			<scope>test</scope>
		</dependency>
		<!-- https://mvnrepository.com/artifact/com.google.guava/guava -->
		<dependency>
			<groupId>com.google.guava</groupId>
			<artifactId>guava</artifactId>
			<version>25.1-jre</version>
			<scope>test</scope>
		</dependency>
```

You'll note, guava 25.1-jre also needs to be included otherwise you will get some pretty weird errors from the Selenium library.

## Write your First Selenium Test

//do stuffs
