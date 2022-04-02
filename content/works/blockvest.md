---
weight: 6
slug: bvm
title: BlockVestMovement
shortAbout: Multi-environment AWS stack design and implementation, CI setup
projectUrl: https://blockvest.com/
main_focus: [devops]
images:
  - stack.png
  - terraform_packer.png
showcaseThumb: how_it_works.png
testimonial: |
  We initially brought Ivan in, to help us move our app that was on a standalone EC2 server to a new AWS VPC that we built out. Ivan was able to envision where we needed to go not just to fix this issue for us, but what would benefit us in the long term with a more Agile and progressive tech stack. He found ways for us to cut costs and grow in a responsible and manageable path that when it's time to scale we will be ready. Ivan's knowledge is vast along with his technical experience which is also with great depths

---
    
Big DevOps job with a lot of complex tasks, pursuing low cost for the client.
On of the cool things I choose is to use [Nomad](https://www.nomadproject.io/) cluster (because we didn't need bloated k8s here), and Nomad+Vault+Consul trio did the work perfectly.

- network design, stack parts selection
- Terraform for setting up AWS for each environment (staging/production), including ELB, CloudFormation, CloudFront etc
- custom AMI's used to provision machines created with [Packer](https://www.packer.io/docs) for each role
- Gitlab's CI used to build and push app's docker images to [Nomad](https://www.nomadproject.io/)'s cluster
- two (scalable) instances of [HAProxy](https://www.haproxy.org/) as a reverse proxy working in pair with [Consul](https://www.consul.io/)
- tens of AWS smaller building block involved, TLS certs, dns, etc
- lots of shell scripting and automation

**NOTE** In Apr 2022 website seems down, but I'm not working on this project for a year now :)
