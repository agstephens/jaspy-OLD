#!/usr/bin/env python

import json
import sys


config = '../etc/minicondas.json'


def _get(py_version, attribute):
    with open(config) as reader:
        data = json.load(reader)

    try:
        source = data['minicondas'][py_version][attribute]
    except:
        print('Could not find {} attribute for python version: "{}"'.format(attribute, py_version))

    return source



if __name__ == '__main__':

    args = sys.argv[1:]
    if len(args) != 2:
        print('Please provide two arguments: the python version to install (e.g. "py3.6")' 
              ' and the attribute required (e.g. "source" or "md5")')

    else:
        print(_get(*args))
