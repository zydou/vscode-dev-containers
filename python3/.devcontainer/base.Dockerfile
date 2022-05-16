ARG VERSION=latest
FROM zydou/mambaforge:${VERSION}

# Copy library scripts to execute
COPY .devcontainer/library-scripts /tmp/library-scripts


# Setup
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && bash /tmp/library-scripts/setup.sh \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/*

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>
