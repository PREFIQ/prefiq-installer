from setuptools import setup

setup(
    name="prefiq-installer",
    version="0.1.0",
    packages=["prefiq_installer"],
    entry_points={
        'console_scripts': [
            'prefiq-install=prefiq_installer.installer:main',
        ],
    },
)
