#!/usr/bin/env python

import json
import sys
import argparse


config = '../etc/minicondas.json'


def _get(py_version, miniconda_version, attribute):
    with open(config) as reader:
        data = json.load(reader)

    if miniconda_version == 'latest':
        _all_versions = [i.split('-')[1] for i in data['minicondas'][py_version].keys()]
        m_start = 'm' + py_version.replace('py', '')[0]
        _all_versions.sort(key=lambda s: map(int, s.split('.')))
        miniconda_version = m_start + '-' + _all_versions[-1] 

    try:
        source = data['minicondas'][py_version][miniconda_version][attribute]
    except:
        print('Could not find {} attribute for python version: "{}"'.format(attribute, py_version))

    return source


if __name__ == '__main__':


    parser = argparse.ArgumentParser()
    parser.add_argument("py_version", type=str, help="Python version")
    parser.add_argument("attribute", type=str, choices=['source', 'md5', 'source_id'],
                        help="Attribute")

    parser.add_argument('-m', '--miniconda-version', default='latest',
                        help='Add Miniconda version (or use "latest").',
                        type=str)
    args = parser.parse_args()
    print(_get(args.py_version, args.miniconda_version, args.attribute))

