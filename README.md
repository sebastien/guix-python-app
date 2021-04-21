# GUIX Python Packaging Tutorial

This repository contains annotated code on how to package and ship a Python
project using [Guix](https://guix.gnu.org/). The key use case here is to
*build reproducible containers* out of a Python repository, effectively using
Guix as the packaging and image building system.

This repository comes with an [annotated Makefile](Makefile), the
[Guix package](package.scm) script, and the [Python setup.py](setup.py) script.


Documents

- [GUIX Reference Manual](https://guix.gnu.org/manual/devel/en/html_node/index.html), the source of truth for how to use Guix
