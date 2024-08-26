#!/bin/bash
pip install maap-dps-jupyter-extension==0.7.2 --index-url https://test.pypi.org/simple/ --extra-index-url https://pypi.org/simple/
pip install maap-jupyter-server-extension==2.0.9 --index-url https://test.pypi.org/simple/ --extra-index-url https://pypi.org/simple/
jupyter server extension enable maap_jupyter_server_extension