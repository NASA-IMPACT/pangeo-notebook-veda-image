FROM pangeo/pangeo-notebook:2024.04.05

USER root

COPY --chown=${NB_USER}:${NB_USER} image-tests /srv/repo/image-tests
COPY --chown=${NB_USER}:${NB_USER} scripts /srv/repo/scripts

USER ${NB_USER}

ADD environment.yml environment.yml

RUN mamba env update --prefix /srv/conda/envs/notebook --file environment.yml

#RUN conda activate /srv/conda/envs/notebook
#RUN pip install git+https://github.com/MAAP-Project/maap-py.git@feature/maappy-gets-username#egg=maap-py
#RUN pip install maap-dps-jupyter-extension==0.7.2 --index-url https://test.pypi.org/simple/ --extra-index-url https://pypi.org/simple/
#RUN pip install maap-algorithms-jupyter-extension==0.3.4
#RUN pip install maap-jupyter-server-extension==2.0.9 --index-url https://test.pypi.org/simple/ --extra-index-url https://pypi.org/simple/
#RUN jupyter server extension enable maap_jupyter_server_extension

