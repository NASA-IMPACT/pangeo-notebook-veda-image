# Pangeo Notebook Veda Image

Docker container based on pangeo-notebook used on VEDA JupyterHub.

## Testing the image

The notebooks in `image-tests/` folder are used to test the docker image. They are run by `repo2docker` github action during the build process and the output is compared to the existing notebooks. You can read more about how the tests are run in the [repo2docker github action documentation](https://github.com/jupyterhub/repo2docker-action?tab=readme-ov-file#testing-the-built-image).

Note that the test notebooks, by default, do not have access to private resources (eg. private S3 buckets).

### Adding new tests

To add new tests, create new notebooks or add to the existing notebooks in `image-tests/` and generate the output of the notebooks by running the following command:

```bash
docker build -t pangeo-notebook-veda .
docker run -v ./image-tests:/srv/repo/image-tests -e REGENERATE_OUTPUTS=true pangeo-notebook-veda bash /srv/repo/scripts/run_tests.sh
```

### Regenrating the output of the test notebooks

To regenerate the output of the test notebooks, we can use the same command we used in the previous section to generate the output of the notebooks while adding new tests:

```bash
docker build -t pangeo-notebook-veda .
docker run -v ./image-tests:/srv/repo/image-tests -e REGENERATE_OUTPUTS=true pangeo-notebook-veda bash /srv/repo/scripts/run_tests.sh
```
This will regenerate the output of the notebooks in place and you can commit the changes to the repository. Tests will fail when the output of the notebooks is different from the existing output. But on subsequent runs, the tests will pass after the output is regenerated.

### Running the test notebooks interactively

To interactively run the test notebooks in a JupiterLab environment locally, run the following command:

```bash
docker build -t pangeo-notebook-veda .
docker run -p 8888:8888 -v ./image-tests:/home/jovyan/image-tests pangeo-notebook-veda jupyter lab --ip 0.0.0.0
```

### Using a Pre-built Image

If you don't want to build the image yourself, you can use a pre-built image from ECR. To run the test notebooks in a JupiterLab environment locally using the pre-built image, run the following command:

```bash
docker run -p 8888:8888 -v ./image-tests:/home/jovyan/image-tests public.ecr.aws/nasa-veda/pangeo-notebook-veda-image:latest jupyter lab --ip 0.0.0.0
```

### Running the tests locally

To run the tests locally, run the following command:

```bash
docker build -t pangeo-notebook-veda .
docker run pangeo-notebook-veda bash /srv/repo/scripts/run_tests.sh
```
