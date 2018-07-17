# jaspy deployment

## Contents

The `deployment` directory contains tools to:

 1. Install miniconda.
 2. Pull a version

## Configuration

The deployment code depends on the following environment variables:

 - `JASPY_BASE_DIR`: 
   - Base directory for installation of JASPY conda environments
   - DEFAULT: `${HOME}/jaspy`
 
## Warning - installations are large!

Note that the software environments managed with `jaspy` are typically
many Gigabytes in size. The default is to install these under the 
`JASPY_BASE_DIR` (see above) inside your `$HOME` directory. Change this
setting if you wish to avoid installing into your `$HOME` directory.
