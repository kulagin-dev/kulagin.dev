---
weight: 4
slug: bestfit
title: Apple pass manager
shortAbout: Apple pass WYSIWYG designer with passbook API integration
main_focus:
  - coding
  - frontend
images:
  - home.png
  - primary.png
  - versions.png
  - versions_schedule.png 
showcaseThumb: home.png
---

AngularJs + Ruby on Rails project with integration with Apple Passbook API and Apple push service.
This project was done solely by myself for BestFit mobile company.

Features implemented:

- WYSIWYG pass designer with near pixel-perfect result with support of all five pass types
- several versions of the same pass supported
- ability to schedule publishing any version to registered devices using APB API (+push service)
- generating and signing passes
- simple and robust hand-crafted image uploading service (instead of Carrierwave or Paperclip). Creating it allowed decoupling image processing and make the whole pass creation process straight and neat.
- a whole bunch of nice other features

The code was heavily tested, and it was relatively easy, thanks to nice gems like
[`light-service`](https://github.com/adomokos/light-service) (I love Command pattern :) and
[`virtus`](https://github.com/solnic/virtus)
