# setup.py
from setuptools import setup, find_packages
import os

# Load version from version.py
version = {}
version_path = os.path.join(os.path.dirname(__file__), "core", "version.py")
with open(version_path) as f:
    exec(f.read(), version)

setup(
    name="prefiq-installer",
    version=version["__version__"],
    description="Prefiq CLI Installer – bootstraps core structure for Prefiq projects.",
    author="Sundar",
    author_email="sundar@prefiq.com",
    license="MIT",
    url="https://github.com/youruser/prefiq",
    packages=find_packages(),
    include_package_data=True,
    install_requires=[
        "requests"
    ],
    entry_points={
        'console_scripts': [
            "prefiq=core.main:main",
        ],
    },
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    python_requires=">=3.12",
)