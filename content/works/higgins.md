---
weight: 3
slug: higgins
title: Higgins MD 420
projectUrl: https://www.higginsmd420.com/
shortAbout: Refactoring and developing web site for Medical Marijuana Evaluation Clinic
images:
  - home
  - step1
  - step2
  - aa_and_pdf
---

Heavy refactoring/cleanup/drying of legacy code and new features implementation.
There was no unit tests at all, and became more than 500 after about three months as I've joined project.

Technologies used:

- common gems toolbox (about one hundred gems; rspec, cucumber, poltergeist, rails 3.2, capistrano, mysql etc.)
- devise with heavy customization to satisfy business needs
- active merchant billing (with authorize.net binding/testing)
- activeadmin with decorated models
- wicked_pdf for health history pdf generation
- cocoon for nested forms
- jenkins CI with github PR triggers
- mercury editor
- errbit
- redmine

Note on frontend: when I joined this project, frontend (including JS) was almost completed, I've done only refactoring of CSS (SCSS+Compass) and JS (CS).
