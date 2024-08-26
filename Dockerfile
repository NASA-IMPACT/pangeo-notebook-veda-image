FROM pangeo/pangeo-notebook:2024.04.05

USER root

COPY --chown=${NB_USER}:${NB_USER} image-tests /srv/repo/image-tests
COPY --chown=${NB_USER}:${NB_USER} scripts /srv/repo/scripts

USER ${NB_USER}

ADD environment.yml environment.yml

ENV CONDA_PREFIX=/srv/conda/envs/notebook
ADD default_pip_packages.sh $CONDA_PREFIX/etc/conda/activate.d/default_pip_packages.sh
ADD custom_pip_packages.sh $CONDA_PREFIX/etc/conda/activate.d/custom_pip_packages.sh
RUN chmod +x $CONDA_PREFIX/etc/conda/activate.d/custom_pip_packages.sh
RUN chmod +x $CONDA_PREFIX/etc/conda/activate.d/default_pip_packages.sh

RUN mamba env update --prefix /srv/conda/envs/notebook --file environment.yml



