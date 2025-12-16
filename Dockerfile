FROM pangeo/pangeo-notebook:2025.08.14

LABEL org.opencontainers.image.source="https://github.com/nasa-impact/pangeo-notebook-veda-image"

USER ${NB_USER}

ADD environment.yml environment.yml

# Configure git to use GitHub PAT if provided
ARG GH_PAT
RUN if [ -n "$GH_PAT" ]; then \
        git config --global url."https://${GH_PAT}@github.com/".insteadOf "https://github.com/"; \
    fi

RUN conda env update --prefix /srv/conda/envs/notebook --file environment.yml

# Clean up git config to remove the token from the image
RUN git config --global --unset-all url."https://github.com/".insteadOf || true

COPY --chown=${NB_USER}:${NB_USER} scripts /srv/repo/scripts