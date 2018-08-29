---
layout: post
title: "Learning from Kademlia"
icon: fa-file-code
#permalink: /blog/2018/08/28/getting-started-ttv4.html
---

At one point or another, I think everyone has wondered how peer discovery works in a distributed system. If that's what you want to hear about, you've come to the right place.

It's hard to give a canonical answer to the "best method," but I will share several methods here and present one which I believe to be the best of those I know of.

# Service discovery and mDNS (Bonjour)

For those of you reading this who didn't grow up with cell phones, you have probably gone into a mall or a large store like Costco and found someone by asking for an announcer to tell the person you're looking for to meet you at the information desk. That's basically what multicast DNS, or mDNS, does. It shouts at every device on its subnet and waits for the device it is looking for to find it.

This works well on home networks where your smart home device just needs to ask questions like "How many light switches are in this house?" but does not scale very well. Imagine how clogged the internet would be (or even a larger network) if devices shouted across the internet to find each other instead of routing.

# Dyjstra's Algorithm

// Should I?

# What is DHT?

If you do any research on the topic, you'll probably end up hearing about BitTorrent and something called DHT.

DHT is the "Distributed Hash Table," essentially a way for peers on the BitTorrent network to find each other. The rough idea of it is that 
