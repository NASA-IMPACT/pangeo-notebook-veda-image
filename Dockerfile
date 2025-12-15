FROM pangeo/pangeo-notebook:2025.08.14

LABEL org.opencontainers.image.source="https://github.com/nasa-impact/pangeo-notebook-veda-image"

USER ${NB_USER}

ADD environment.yml environment.yml

RUN conda env update --prefix /srv/conda/envs/notebook --file environment.yml

COPY --chown=${NB_USER}:${NB_USER} scripts /srv/repo/scripts