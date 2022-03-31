---
weight: 5
slug: instamotor
title: Instamotor Inc.
projectUrl: https://instamotor.com/
shortAbout: Refactoring and extending communication layer using Twilio
main_focus:
  - coding
images:
  - home.png
  - twilio_relay.png
  - twilio_uml.png
  - working.png 
showcaseThumb: home.png
---

The project consists of two parts: main grape-based API backend and web crawler, gathering vehicle sell postings from the web.
API includes tricky communication layer based on [Twilio](https://www.twilio.com).
My noticeable goals were:

- migrate both apps from Resque to Sidekiq (jobs rework, queues tuning)
- add Sidekiq monitoring and logging extensions
- refactor/add MMS handling for Twilio
- leasing and freeing Twilio phone numbers
- forwarding calls/[steganography](https://en.wikipedia.org/wiki/Steganography) (shown on screenshot)
- Amazon EC2 instances managing and tuning
- rewrite and make testable internal Slack messenger (shown on screenshot)
- integration with NewRelic, Rollbar, Papertrail and Dead Man’s Snitch 3rd-party services
- plenty of small refactorings (code had low quality)

And of course everything was tested with Rspec.

**NOTE**: my goals were related to backend only
