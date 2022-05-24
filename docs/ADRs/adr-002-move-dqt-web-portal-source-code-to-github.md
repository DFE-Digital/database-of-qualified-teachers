# 002 - Move DQT Web Portal source code from Azure Devops to Github

**Date: 28-10-2021**
**Date: 06-05-2022**

## Status
**Accepted**

## Context
The current DQT Web Portal source code is kept in Azure DevOps within the Tier 1 DfE subscription. Even though Azure DevOps provides a set of tools necessary for hosting source code, implementing continuous integration, delivery and testing workflows, Github provides a much more developer friendlier experience.

Github is the de facto choice of hosting code repositories amongst developers, and it's the most common choice for engineering teams in DfE. This makes it easier to use, and it's in line with the team appetite for better communication and integrations with other service teams.

## Decision
We will move the DQT Web Portal source code into Github from Azure DevOps.

## Consequences
The current codebase has some secrets (API keys, credentials) hardcoded and visible. Before we can safely move the code, we need to either extract those secrets into environment variables inserted in the running application by the release pipeline.

Another option is to have a momentarily private Github repository until we have hidden all the secrets, as explained earlier.

We will rewire the current test and release pipelines defined in Azure DevOps so that Github pull request merges trigger them.
