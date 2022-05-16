#!/bin/bash

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# Ensure that login shells get the correct path if the user updated the PATH using ENV.
rm -f /etc/profile.d/00-restore-env.sh
echo "export PATH=${PATH//$(sh -lc 'echo $PATH')/\$PATH}" > /etc/profile.d/00-restore-env.sh
chmod +x /etc/profile.d/00-restore-env.sh

# Setup default python tools in a venv via pipx to avoid conflicts
PIPX_PKGS=("pre-commit")
for pkg in ${PIPX_PKGS[@]}; do
    if ! type ${pkg} > /dev/null 2>&1; then
        pipx install --system-site-packages --pip-args '--no-cache-dir --force-reinstall' ${pkg}
    else
        echo "${pkg} already installed. Skipping."
    fi
done

# Install packages to base env via mamba
mamba install -y -n base numpy pandas scipy matplotlib scikit-Learn seaborn jupyterlab ipdb pytest
rm -rf /opt/conda/pkgs

# Clean up
rm -rf /tmp/library-scripts
echo "Done!"
