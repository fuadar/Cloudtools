# Cloudtools
A simple Docker image to setup all the cloud tools for OCI and OCI-C

This Image uses the Oracle 7-slim image from dockerhub and uses a /data and /files framework.

The following files need to be downloaded 

1. Sqlcl from http://www.oracle.com/technetwork/developer-tools/sqlcl/downloads/index.html
2. PSMcli from https://docs.oracle.com/en/cloud/paas/java-cloud/pscli/downloading-command-line-interface.html

The image will install python 34 and pip and download oci-cli as well.

This will give user access to the PaaS Service Manager Cli, Oracle Cloud Infrastructure Cli and sqlcl to connect to a database all in one image

the Installs will be in /data volume 

you can have a /files logical volume to allow for psm setup commands and have json files for creating services etc
Example Docker run command for this 
docker run \
  --interactive --tty --rm \
  --volume "$PWD":/data \
  oracle/cloudtools:2.0.6 "$@"
