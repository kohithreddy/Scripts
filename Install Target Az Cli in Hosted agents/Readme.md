# Downgrading Azure CLI Version in Azure DevOps

**Author:** Kohith Reddy  
**Date:** 05 Oct 2023

## Scenario

You may want to downgrade the Azure CLI version in Azure DevOps when using the Microsoft-hosted Ubuntu 20.04 pool. The attached YAML script in this folder demonstrates how to identify the existing version of Azure CLI and revert it to a specific version on the Microsoft-hosted agent using the [`ubuntu-22.04`](https://github.com/actions/runner-images/blob/main/images/linux/Ubuntu2204-Readme.md) or [`ubuntu-latest`](https://github.com/actions/runner-images/blob/main/images/linux/Ubuntu2204-Readme.md) pool.

[Link to YAML script](InstallTargetAzcli.yaml)
