# Updating 2i2c's Singleuser Image for VEDA JupyterHubs

JupyterHub configuration has the concept of a `singleuser` image that is the 
[default image for spinning up user pods](https://z2jh.jupyter.org/en/stable/jupyterhub/customizing/user-environment.html#choose-and-use-an-existing-docker-image).

Currently https://staging.nasa-veda.2i2c.cloud/ and https://nasa-veda.2i2c.cloud/ both use the custom image from this repository as the default. 
Below we walk through how to update this image and get it in these VEDA JH instances. This allows us to add 
custom packages without us needing to request these custom packages upstream in the `pangeo-notebook` image.

## Update the Conda Environment

1. Clone this repo

2. Create a new branch `git checkout -b feature/update_package_<xyz>`

3. and open `environment.yml`. It might look something like this: 

```yaml
channels:
  - conda-forge
  - nodefaults
dependencies:
  - ipykernel
  # Dependencies for VS Code IDE
  - code-server>=3.2
  - jupyter-vscode-proxy
  - openssh
  - pre_commit
  - pip
  - pip:
    - git+https://github.com/MAAP-Project/stac_ipyleaflet.git@0.3.6
    - jupyter-sshd-proxy
    - jupyterlab-bxplorer
variables:
  TITILER_STAC_ENDPOINT: 'https://openveda.cloud/api/stac'
  TITILER_ENDPOINT: 'https://openveda.cloud/api/raster'
  STAC_CATALOG_NAME: 'VEDA STAC'
  STAC_CATALOG_URL: 'https://openveda.cloud/api/stac'
  STAC_BROWSER_URL: 'https://openveda.cloud/'
```

4. Add the pip packages or conda packages you need installed in the `dependencies` block

5. commit and push changes to the remote feature branch and create a PR

## Test the Image on staging

1. Once the changes are pushed to a remote branch on this repo, GH actions will automatically run the image building pipeline. You can watch this in the [GH actions tab](https://github.com/NASA-IMPACT/pangeo-notebook-veda-image/actions)

2. Look for the workflow named `Build and push container image` for the most recent commit to your branch. Click into the workflow run to see more details on what is happening.

3. Once the workflow run completes you should see something like the following in the `Tag and push image` step which indicates the image was built successfully.

```bash
Run FULL_IMAGE_NAME=public.ecr.aws/nasa-veda/pangeo-notebook-veda-image
The push refers to repository [public.ecr.aws/nasa-veda/pangeo-notebook-veda-image]
...
...
f521e8d7b8b9: Pushed
18b1f1fbf84a: Pushed
b98733c8ba26: digest: sha256:51d2a3c6e089006b4b9246251a5e046f490f78758796f7bf4345d4777bef16f2 size: 4500
Pushed image: public.ecr.aws/nasa-veda/pangeo-notebook-veda-image:b98733c8ba26
```

Note the full image URI will be `public.ecr.aws/nasa-veda/pangeo-notebook-veda-image:<imageTag>`. The `imageTag` should match the latest commit hash of your branch.

4. Copy the image URI from the logs of the GH action run that looks like `public.ecr.aws/nasa-veda/pangeo-notebook-veda-image:<commit-hash>`. We can test this image on staging by going to https://staging.nasa-veda.2i2c.cloud/hub/spawn and selecting "Other" from the "Image" dropdown. 

5. In the "Custom image" input box, paste the image URI from the logs of the GH action run and click "Start".

6. If all goes well, you'll see the Jupyter server start up with your custom packages.

7. If everything works as expected, you can go back to the PR and request a review or merge it into `main` as appropriate.

8. Once the PR is merged, it should trigger a new GH action to build the image and push it to ECR. Once the image is pushed, we can get the image tag from GH actions by following the steps outlines above in point 3.

9. Now we need to update the singleuser image in 2i2c's infrastructure repo.

## Update the Singleuser Image for VEDA JupyterHubs in 2i2c's Infrastructure Repo

1. If you haven't already [clone DS's fork](https://github.com/developmentseed/infrastructure/) of [2i2c's insfrastructure repo](https://github.com/2i2c-org/infrastructure)

2. In the pangeo-notebook-veda-image repository, create a release branch with the name `release/YYYY.MM.DD-vX`, where `YYYY.MM.DD-vX` is the next tag. The tag should be of the form `YYYY.MM.DD-vX`, where:
   - `YYYY.MM.DD` should match the tag of the pangeo-notebook base image
   - `vX` is the version number, starting with `v1` and incrementing for subsequent versions on the same date

   For example: `2024.06.02-v1`

3. Update the CHANGELOG.
    - Create a new header below `## [Unreleased]` with the new version.
    - Remove any unused header sections.
    - Update the links at the bottom of the page for the new header.

4. Commit your changes, push your branch to Github, and request a review.

5. Once approved, merge the PR.

6. Create and push the tag using the same tag name as the release branch. For example:

   ```bash
   git tag 2024.06.02-v1
   git push origin 2024.06.02-v1
   ```

7. Once the tag is pushed, GH actions will automatically run the image building pipeline. You can watch this in the [GH actions tab](https://github.com/NASA-IMPACT/pangeo-notebook-veda-image/actions). Once the image is build and pushed to ECR, we can update the singleuser image in the infrastructure repo.

8. In `config/clusters/nasa-veda/common.values.yaml`, update the profile choice corresponding to the Pangeo image in the `singleuser` image block and open a PR to [2i2c's insfrastructure repo](https://github.com/2i2c-org/infrastructure). Use the new image URI with the tag we just created. For example: `public.ecr.aws/nasa-veda/pangeo-notebook-veda-image:2024.06.02-v1`.

It's recommended to update the staging hub's image first. Once that's verified to work, update the production hub's image.

5. After the PR is created, reviewed and merged, 2i2c's CI/CD process will automatically deploy the image to staging and production hubs as needed.
