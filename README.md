# Demo Of Ansible Development In OpenShift Dev Spaces

This repo contains a very simple Ansible example with an Eclipse Che / Dev Spaces `devfile.yaml` to demonstrate how Ansible development can be done in OpenShift Dev Spaces / Eclipse Che.

This capability will be especially useful for developers and engineers who do not have access to a container runtime on their local workstation.

## Set Up For Demo

Before you can run this, you need access to an OpenShift cluster that has Dev Spaces installed and is configured for a nested container runtime.  Minimum OCP version is 4.20, Minimum Dev Spaces version is 3.25

## Run The Demo

1. Log into Dev Spaces / Eclipse Che as a non-admin user.  (It's no fun if you use `cluster-admin` for everything)
1. Create a new Workspace from this git repo: `https://github.com/cgruver/che-ansible-demo.git`
1. Wait for the workspace to start.
1. Open a terminal in the workspace.
1. Run `ansible-navigator run helloworld.yaml`.

That's it.
