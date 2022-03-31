---
weight: 6
slug: spinfluenceit
title: spINFLUENCEit
shortAbout: Complex backend for iOS and macOS applications
projectUrl: https://spinfluenceit.com/
testimonial: |
  Ivan is the best freelancer out there, you can't find any better! I have worked with Ivan for a couple hundred hours over several months and was always happy.
  I work in the IT industry myself and I have rarely met a guy with such a broad and deep knowledge as Ivan. Neither have I met a guy who tests his code and maintains the test suite in sync with the code as thoughtfully and meticulously as Ivan does. He writes documentation and takes notes and can get back to you weeks and months later and still knows what has been discussed in conversations.
  A true professional and I'm looking forward to working with him again!
main_focus:
  - coding
images:
  - screen_1.jpg
  - screen_2.jpg
  - screen_3.jpg
  - screen_4.jpg
showcaseThumb: showcase.jpg
nothumbs: true
---

Long-term API project, where I was a head developer of backend side of two applications:
 
- one DJ's desktop app which DJ use to notify the crowd the track he's playing, respond to music requests, upload his music collection metadata people able to search in, etc. 
- and the second app is a mobile app for party guests, where people can order, vote, like the currently playing track, send tips to DJ, search the DJ's music collection etc. 

Initially the app were built on Ruby on Rails, but soon we decided to replace it with **Grape**, just because we were not need Rails beast for API, that migration increased performance a lot. As a free bonus we've got a **swagger docs** for API for free.  **Hanami**  (formerly Lotusrb)wasn't mature enough yet, but today I'd definitely use it instead (or even clean Rack app), additionally replacing ActiveRecord which I consider as an antipattern for everything but MVP.

Interesting design decisions/stack used:

- **Firebase for authentication**
- **Google Cloud Messaging**  to interact with guest's mobile application (broadcasts, direct messages)
- heavy use of bz2 streams to transfer huge DJ's music collection metadata
- stream compressed metadata in **NDJSON** format
- PG per-DJ partitioning (at those times there wasn't native PG solution for that out of the box)
- multiple external musical APIs integration (cover images look up, search song my fingerprint etc). At some point each background track normalization process called 5 different external APIs  
- of course most core features where covered by tests (unit/feature al kind of, depending on what was the goal of tests)
- custom **Firebase authentication**  ``warden`` strategies implemented for both roles: DJ and Guest
- few PG triggers implemented on **PL/pgSQL** to ease work with millions of music tracks data records
- **Braintree** payments integration
- using **[Que](https://github.com/que-rb/que)** for background tasks (client want no additional elements like Redis in stack)
- simple **S3 integration**

This was a very interesting experience, where I had to use all my knowledge about performance optimization and big project (with lots of data) leading development
