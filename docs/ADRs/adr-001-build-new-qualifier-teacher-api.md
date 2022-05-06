# 001 - Build a new Qualified Teacher API

**Date: 25-10-2021**

## Status
**Accepted**

## Context
### Teaching Regulation Agency
The Teaching Regulation Agency is currently undergoing a digital transformation, and a Discovery into the TRA has revealed inefficiencies in how the TRA and its systems interact with other services. These inefficiencies have arisen from multiple conversations with other services teams and stakeholders with Teacher Services.

Additionally, the current digital services landscape of Teacher Services and Teaching Regulation Agency is constantly changing. The department is re-imagining what education services look like from the teacher perspective. New and old services and their respective software systems are being created or being changed. 

A few examples are the new Register Trainee Teacher, Teacher Identity and Continuous Professional Development Services.

Functions provided by services are now duplicated in other TRA services and other newer digital services available to users across the department. Service definitions are unclear or have been subject to scope creep since launch. 

The service requires an API that meets Service level objectives, well-defined service definition, and aligns with DfE and Government technical standards.

## Decision
We will build a new API application to replace the current one. We will not be continuing the integration with EAPIM as it adds too much overhead for too little benefit and compromises user experience and flexibility.

We will implement authentication and authorisation for our users as well as point them to our documentation.

## Consequences
Our users and the engineering team won't have to manage two different tokens for authentication (one for EAPIM gateway and one for the backend).
Our Service Team will be directly responsible for granting access to the API as opposed to delegating that responsibility to an external team that doesn't understand who is a valid user or not.


Given DQT is classified by InfoSec as a gold service, we might have to explain the reason behind our choices in some governance processes.
