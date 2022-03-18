from os import path
from setuptools import setup


install_requirements = ['setuptools']

dev_requirements = ['pylint', 'autopep8', 'pylint-flask']

setup(name='demo',
      install_requires=install_requirements,
      extras_require={'dev': dev_requirements}
      )
