#!/usr/bin/env python3
from distutils.core import setup
setup(
    name="guix-python-app",
    package_dir={"": "src/py"},
    packages=["guixpythonapp", ],
    scripts=["bin/guix-python-app"],
    install_requires=["pytz"]
)
# EOF
