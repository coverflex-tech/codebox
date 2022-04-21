# Coverflex DevOps challenge

## Overview

The Coverflex development team built the Codebox application and would like to take it to production soon. For this challenge we would like you to write a small case study about how would you, as the DevOps engineer assigned to this, would setup the necessary infrastructure and procedures to support the application from development to production. Consider we use **AWS** in Coverflex as our cloud provider.

Any code snippets or scripts included will be **highly valued** in the review of your challenge.

## Basic Requirements

- Besides the production environment, the team needs, at least, one (each) pre-production and development environments.
- The test suite must be ran before every deployment.
- The database must be updated with any pending database migrations in the application before every deployment.
- The team should have access to metrics to evaluate the health of the system and alarmistic.

## Some basic questions we might ask

- How does your infrastructure scale with the increasing traffic?
- How does your deployment process ensure that we deploy to production reliable versions of our application?
- How does the infrastructure react to failures?
- Is is possible to rollback to a previous version if something goes wrong with a particular deployment?
- What security considerations did you make?
- How maintainable is our infrastructure in long term? How hard it is to expand with new features?
- How do you package the application for deployment?
- Where do you keep the build artifacts?