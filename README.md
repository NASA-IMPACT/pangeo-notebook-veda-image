# Pangeo Notebook Veda Image

Docker image based on pangeo-notebook used on VEDA JupyterHub.

## What's in the image

The image builds off a particular tagged version of the [pangeo-notebook image](https://github.com/pangeo-data/pangeo-docker-images/tree/master/pangeo-notebook). Which tag in particular is specified in [the first line of the Dockerfile](https://github.com/NASA-IMPACT/pangeo-notebook-veda-image/blob/main/Dockerfile#L1). You can figure out which packages are included in that version of pangeo-notebook image by checking the [environment.yml](https://github.com/pangeo-data/pangeo-docker-images/blob/master/pangeo-notebook/environment.yml) and the exact versions by checking [packages.txt](https://github.com/pangeo-data/pangeo-docker-images/blob/master/pangeo-notebook/packages.txt).

The image adds additional packages and environment variables specified in [environment.yml](environment.yml) without updating the existing libraries included in the default pangeo-notebook image.

## How to use the image

On each commit to this repository a new image is tagged and pushed to ECR. You can find the name of that image in the Github action that pushes it. The image name looks like:

- public.ecr.aws/nasa-veda/pangeo-notebook-veda-image:2025.08.14-v2  _for git tags_
- public.ecr.aws/nasa-veda/pangeo-notebook-veda-image:d6df85b998c3   _for regular git commits_

That image name can be used on a JupyterHub that supports "Bring your own image". Just paste the image name into the "Custom image" input.

## Testing the image

The notebooks in `image-tests/` folder are used to test the docker image. They are run by `repo2docker` github action during the build process and the output is compared to the existing notebooks. You can read more about how the tests are run in the [repo2docker github action documentation](https://github.com/jupyterhub/repo2docker-action?tab=readme-ov-file#testing-the-built-image).

Note that the test notebooks, by default, do not have access to private resources (eg. private S3 buckets).

### Adding new tests

To add new tests, create new notebooks or add to the existing notebooks in `image-tests/` and generate the output of the notebooks by running the following command:

```bash
docker build -t pangeo-notebook-veda .
docker run -v ./image-tests:/srv/repo/image-tests -e REGENERATE_OUTPUTS=true pangeo-notebook-veda bash /srv/repo/scripts/run_tests.sh
```

### Regenerating the output of the test notebooks

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
