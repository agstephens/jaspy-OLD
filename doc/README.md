# Developing Help documentation for JASPY on JASMIN

We are trialling a new system for building and managing Python environments on JASMIN. There is a prototype Python 3.6 environment that you can try out which is mounted under `/apps/contrib/` across all the main LOTUS and `jasmin-sci*` servers. You can activate it with:

```
export PATH=/apps/contrib/jaspy/miniconda_envs/jaspy3.6/m3-4.5.4/bin:$PATH
source activate jaspy3.6-m3-4.5.4-r20180816
```

After that set-up your default python (for the current session) will be python 3.6.5.

Documentation on this approach, and the available environments, will appear in due course.

## Creating your own software environments "on top of" a JASPY environment

```
# Set path and activate conda environment
export PATH=/apps/contrib/jaspy/miniconda_envs/jaspy3.6/m3-4.5.4/bin:$PATH
source activate jaspy3.6-m3-4.5.4-r20180816

# Create your own virtualenv - you only do this once!
virtualenv --system-site-packages my-venv

# Activate your virtualenv
source my-venv/bin/activate

# Install some package into your virtualenv - only do this once!
pip install pytest

# Test we can import a package in the main conda env AND one in our own venv
python -c 'import matplotlib; import pytest'

# ...which would raise an exception if it couldn't find either package.
```

And then whenever you just want to use the environment, just do:

```
export PATH=/apps/contrib/jaspy/miniconda_envs/jaspy3.6/m3-4.5.4/bin:$PATH
source activate jaspy3.6-m3-4.5.4-r20180816
source my-py3-venv/bin/activate
```
Which ideally you would put in a setup script.
