# Creating Custom Images

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

4. Add the pip packages or conda packages you need installed in the `dependencies` block. Or any other customizations you need.

5. commit and push changes to a remote branch on **this repo**.

6. Once the changes are pushed to a remote branch on this repo, GH actions will automatically run the image building pipeline. You can watch this in the [GH actions tab](https://github.com/NASA-IMPACT/veda-jh-environments/actions)

7. Look for the workflow named `Build and push container image` for the most recent commit to your branch. Click into the workflow run to see more details on what is happening.

8. Once the workflow run completes you should see something like the following in the `Tag and push image` step which indicates the image was built successfully.

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

10. Copy the image URI from the logs of the GH action run that looks like `public.ecr.aws/nasa-veda/pangeo-notebook-veda-image:<commit-hash>`. We can test this image on staging by going to https://staging.nasa-veda.2i2c.cloud/hub/spawn and selecting "Other" from the "Image" dropdown.

11. In the "Custom image" input box, paste the image URI from the logs of the GH action run and click "Start".

12. If all goes well, you'll see the Jupyter server start up with your custom changes.
