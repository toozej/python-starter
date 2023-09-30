from setuptools import setup
import os

VERSION = "0.1"


def get_long_description():
    with open(
        os.path.join(os.path.dirname(os.path.abspath(__file__)), "README.md"),
        encoding="utf8",
    ) as fp:
        return fp.read()


setup(
    name="python-starter",
    description="python-starter",
    long_description=get_long_description(),
    long_description_content_type="text/markdown",
    author="toozej",
    url="https://github.com/toozej/python-starter",
    project_urls={
        "Issues": "https://github.com/toozej/python-starter/issues",
        "CI": "https://github.com/toozej/python-starter/actions",
        "Changelog": "https://github.com/toozej/python-starter/releases",
    },
    license="GNU, Version 3.0",
    version=VERSION,
    packages=["python_starter"],
    entry_points="""
        [console_scripts]
        python-starter=python_starter.cli:cli
    """,
    install_requires=["click"],
    extras_require={"test": ["pytest"]},
    python_requires=">=3.11",
)
