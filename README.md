# Example containerized Github Runner for Yocto builds

This repo demonstrates how to run a containerized self-hosted Github runner that is setup to do Yocto builds.

## How to build

You can build this container with a simple `docker build -t <name> .`

## How to use/run

Here is the standard `docker run` command to run this container:

```
docker run -d -it --rm -v $(pwd):/workdir --workdir=/workdir --env REPO=<REPO> --env ACCESS_TOKEN=<ACCESS_TOKEN> --name runner <container image name> start.sh
```

* REPO: This is the repository for which you want the runner added to. For example for repo `https://github.com/foo/bar`, you want to set `REPO` to `foo/bar`.
* ACCESS_TOKEN: This is a token that has access to the "registration-token" api endpoint for whatever repo or organization you want to add this runner to. See [here](https://docs.github.com/en/rest/actions/self-hosted-runners?apiVersion=2022-11-28#create-a-registration-token-for-a-repository) for more info.
* This container has a bind-mount to `/workdir` in the container. This is so the build output from the Yocto build will also be available on the host system should the container suddenly exit. Make sure your Github Actions are configured to use the same working-directory so that the Yocto build is performed in the expected location.

If successful you should see output like this in the container logs:

```
--------------------------------------------------------------------------------
|        ____ _ _   _   _       _          _        _   _                      |
|       / ___(_) |_| | | |_   _| |__      / \   ___| |_(_) ___  _ __  ___      |
|      | |  _| | __| |_| | | | | '_ \    / _ \ / __| __| |/ _ \| '_ \/ __|     |
|      | |_| | | |_|  _  | |_| | |_) |  / ___ \ (__| |_| | (_) | | | \__ \     |
|       \____|_|\__|_| |_|\__,_|_.__/  /_/   \_\___|\__|_|\___/|_| |_|___/     |
|                                                                              |
|                       Self-hosted runner registration                        |
|                                                                              |
--------------------------------------------------------------------------------

# Authentication


√ Connected to GitHub

# Runner Registration




√ Runner successfully added
√ Runner connection is good

# Runner settings


√ Settings Saved.


√ Connected to GitHub

Current runner version: '2.313.0'
2024-02-24 00:05:21Z: Listening for Jobs
```

Once the container stops/exits the runner should remove itself. As a final note this repo also has `example-ci.yml` to show how to use this runner to perform Yocto builds via Github Actions. 
