# Project factory

The Project Factory (or PF) builds on top of your foundations to create and setup projects (and related resources) to be used for your workloads.
It is organized in folders representing enviroments (e.g. "dev", "prod"), each implemented by a stand-alone terraform [resource factory](https://medium.com/google-cloud/resource-factories-a-descriptive-approach-to-terraform-581b3ebb59c).

This directory contains a single project factory ([`prod/`](./prod/)) as an example - in order to implement multiple environments (e.g. "prod" and "dev") you'll need to copy the `prod` folder into one folder per environment, then customize each one following the instructions found in [`prod/README.md`](./prod/README.md).