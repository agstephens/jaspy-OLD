# jaspy
Conda environments for JASMIN (and beyond)

## Overview

This package provides the instructions and full specifications for a
collection of software environments built on top of the [conda](https://conda.io/)
package. The environments are primarily built to run on the [JASMIN](http://jasmin.ac.uk)
platform but they may be applicable for other uses.

## Why conda?

[Conda](https://conda.io/docs/user-guide/) is a package management system that has emerged 
from the Python community. It is an open source and runs on Windows, macOS and Linux. Conda 
can be used to install, run and update packages and their dependencies. It includes features 
to create, save, load and switch between environments on your local computer. It was created 
for Python programs, but it can package and distribute software for any language.

### Conda, Anaconda and Miniconda

The ecosystem of conda tools includes three main players. It is useful to understand the 
distinction between them:

 - **Conda**:	The package management system itself.
 - **Anaconda**:	A pre-selected set of (over 250) scientific software packages that can
	 be installed in a single (conda) environment.
 - **Miniconda**:	A basic installer that contains an entire Python installation and the
 	 conda package manager.

In this plan we are only concerned with conda and miniconda. It is necessary to start with 
miniconda in order to get a baseline python and conda installation. Once that is in place 
conda is available to create and manage multiple environments.

## Workflows

There are four workflows related to `jaspy`:

 1. **User** workflow:
   - Activate a `jaspy` environment
   - Use software in that environment 

 2. **Platform Administrator** workflow:
   - Install `jaspy`
   - Install environment(s)
   - Document usage of environment(s) for users

 3. **Environment Developer** workflow:
   - Install `jaspy`
   - Develop new environment(s)
   - Save the new environment(s)
   - Test the installation of the new environment(s)
   - Commit the new environments(s) to the repository

 4. **Jaspy Core Developer** workflow:
   - Install `jaspy`
   - Develop and improve the core framework.
   - Test and update the code.

### Workflow 1: User

Assuming that a Platform Administrator has installed `jaspy` then you can use it as
explained here. Get your settings as recommended by your administrator:

```
export JASPY_INSTALL_DIR=...GET_THIS_FROM_YOUR_ADMINISTRATOR...
export PY_VERSION=python3.6
export PATH=${JASPY_INSTALL_DIR}/${PY_VERSION}/bin:$PATH
```

List the available `jaspy` conda environments:

```

$JASPY_BASE_DIR/bin
