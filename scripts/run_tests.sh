export PYTEST_FLAGS="";

# If there is a requirements.txt file inside image-tests, install it.
# Useful if you want to install a bunch of pytest packages.
[ -f /srv/repo/image-tests/requirements.txt ] && \
    echo "Installing from /srv/repo/image-tests/requirements.txt..." && \
    python3 -m pip install --no-cache -r /srv/repo/image-tests/requirements.txt;

# If pytest is not already installed in the image, install it.
which py.test > /dev/null || \
    echo "Installing pytest inside the image..." && \
    python3 -m pip install --no-cache "pytest<9" > /dev/null;

# If there are any .ipynb files in image-tests, install pytest-notebook
# if necessary, and set PYTEST_FLAGS so notebook tests are run.
ls /srv/repo/image-tests/*.ipynb > /dev/null && \
    echo "Found notebooks, using pytest-notebook to run them..." && \
    export PYTEST_FLAGS="--nb-test-files ${PYTEST_FLAGS}" && \
    python3 -c "import pytest_notebook" 2> /dev/null || \
        python3 -m pip install --no-cache pytest-notebook;

# If regeneration flag is set, add it to the pytest flags
[ -n "${REGENERATE_OUTPUTS}" ] && \
    echo "Regenerating notebook outputs..." && \
    export PYTEST_FLAGS="--nb-force-regen ${PYTEST_FLAGS}";

py.test ${PYTEST_FLAGS} /srv/repo/image-tests/
