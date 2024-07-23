FROM pangeo/pangeo-notebook:2024.06.02

LABEL org.opencontainers.image.source="https://github.com/nasa-impact/pangeo-notebook-veda-image"

USER root

COPY --chown=${NB_USER}:${NB_USER} image-tests /srv/repo/image-tests
COPY --chown=${NB_USER}:${NB_USER} scripts /srv/repo/scripts

USER ${NB_USER}

ADD environment.yml environment.yml

RUN mamba env update --prefix /srv/conda/envs/notebook --file environment.yml
