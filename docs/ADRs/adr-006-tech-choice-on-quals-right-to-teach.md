## 006 - Choose HL Technical Direction For Quals and Right To Teach Services

**Date: 15-02-2023**

## Status

Proposed

## Context

In order to proceed on iteration 1 of the Teacher Self Serve Portal replacement aka (Qualifications Service / Teacher Account / Teacher Self Serve TBC),
we want to decide on the following
1. Proposed tech for each service?
2. One Front end application (in code repo terms) or two?
3. How will we abstract away underlying data dependencies while we have high uncertainty on service design?
4. Datasources?

## Decision

1. This is not a technical issue (i.e. either is fine from a tech POV), this is more a resource decision. TBC but the assumptions at the time of writing are:
    Right To Teach (Ruby On Rails) + PostgreSQL
    Qualifications (Ruby On Rails) + PostgreSQL
2. Qualifications will proceed with a qualifications only repo, defer decision until Right To Teach is closer to cutting code.
3. Add new /v3 endpoints to existing Qualifications API (.Net). The API will do all heavy lifting on behalf of both services.
4. For iteration 1 of the Qualifications service we will use DQT only. This will be re-visited at further iterations, we fully expect this to change as data
   is migrated out of DQT. Qualifications and Right To Teach Service data will live in their respective service databases (Postgres)

## Consequences

It enables us to start work on the Qualifications service.
