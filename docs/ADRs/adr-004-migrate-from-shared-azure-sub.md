# Migrate from shared Azure subscription

**Date: 06-05-2022**

## Status
**Accepted**

## Context
Most of the DQT technical architecture resides in a shared subscription. This makes it impossible for service teams to get the necessary level of access to the components without raising service tickets. This does not enable us as a service team to efficiently meet the needs of the Teacher Regulation Agency and their service users.

## Decision
Any new / heavily refactored components will be hosted in either Azure (non shared sub) or GOVPAAS.

## Consequences
This makes it possible to fully support all service components and reduces the reliance on external parties, allowing us to react more quickly to issues and implement change quicker. It also reduces poterntial security risks due to lack of control (on our part) of who access TRA data.
