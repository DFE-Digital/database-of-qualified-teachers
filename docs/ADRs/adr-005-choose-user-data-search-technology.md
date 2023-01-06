# 005 - Choose User Data Search Technology

**Date: 06-01-2023**

## Status

**Accepted**

## Context
Moving searching away from the CRM is a technical enabler allowing a de-coupled (from CRM) way of internal and external (i.e. other TS services) from searching / matching / consuming DQT data entities without affecting CRM performance.  
It also allows us to remove CRM (eventually) more easily in the future.
There is also the need to be able to performantly search user data in Get An Identity to avoid potential data duplication.
POC solutions looked at both Lucent.NET and PostgreSQL technologies.

## Decision
We will maintain denormalised user attribute data (e.g. first name, last name, date of birth etc.) in PostgreSQL as it is performant to search against and fits well with existing infrastructure.

## Consequences
Better user experience due to relevant services being able to perform searches more efficiently.
