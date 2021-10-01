#!/bin/sh
set -eu

# Recursively build docker images
recursive_build() {
  path=$1
  tag=$2
  release=$3
  extra=$4
  for dir in $path/docker/*; do
    if [ -d "${dir}" ]; then
      distro=$(basename "${dir}")

      if [ "${distro}" = "amazon" ]; then
        continue # FIXME, (See: https://github.com/aad-for-linux/libnss_aad/commit/97304f5f00ff88f65a6d9078f2b9baa6509da9d7).
      fi

      image="${tag}:${distro}" # org/image:tag
      if [ ! -z "${extra}" ]; then
        image="${tag}:${distro}-${extra}" # org/image:tag-extra
      fi
      docker build --build-arg VERSION="${release}" \
                   --build-arg DEBVER=1 \
                   -t "${image}" "${path}" \
                   -f "${dir}/Dockerfile"
    fi
  done
}

main() {
  DEFAULT_IMAGE="aad-for-linux/libnss_aad"
  export RELEASE=$(git describe --tags $(git rev-list --tags --max-count=1))

  # Build all docker images
  recursive_build . "${DEFAULT_IMAGE}" "${RELEASE}" ''

  # Build all testing docker images
  recursive_build ./test "${DEFAULT_IMAGE}" "${RELEASE}" 'testing'

}

main
