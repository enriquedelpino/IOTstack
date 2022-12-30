# supported build argument
ARG NGINX_PROXY_MANAGER_BASE=jc21/nginx-proxy-manager:latest

# Download base image
FROM $NGINX_PROXY_MANAGER_BASE

# re-reference supported argument and copy to environment var
ARG NGINX_PROXY_MANAGER_BASE
ENV NGINX_PROXY_MANAGER_BASE=${NGINX_PROXY_MANAGER_BASE}

# see https://github.com/alpinelinux/docker-alpine/issues/98
#RUN sed -i 's/https/http/' /etc/apk/repositories

# Add support tools
RUN apk update && apk add --no-cache rsync tzdata

# where IOTstack template files are stored
ENV IOTSTACK_DEFAULTS_DIR="iotstack_defaults"

# copy template files to image
COPY --chown=root:root ${IOTSTACK_DEFAULTS_DIR} /${IOTSTACK_DEFAULTS_DIR}

# copy the health-check script into place
#ENV HEALTHCHECK_SCRIPT "iotstack_healthcheck.sh"
#COPY ${HEALTHCHECK_SCRIPT} /usr/local/bin/${HEALTHCHECK_SCRIPT}

# define the health check
#HEALTHCHECK \
#   --start-period=30s \
#   --interval=30s \
#   --timeout=10s \
#   --retries=3 \
#   CMD ${HEALTHCHECK_SCRIPT} || exit 1

# replace the docker entry-point script
ENV IOTSTACK_ENTRY_POINT="docker-entrypoint.sh"
COPY ${IOTSTACK_ENTRY_POINT} /${IOTSTACK_ENTRY_POINT}
RUN chmod 755 /${IOTSTACK_ENTRY_POINT}
ENV IOTSTACK_ENTRY_POINT=

# IOTstack also declares these paths
VOLUME ["/data/nginx/proxy_host"]

# set container metadata
LABEL com.github.SensorsIot.IOTstack.Dockerfile.build-args="${NGINX_PROXY_MANAGER_BASE}"
LABEL com.github.SensorsIot.IOTstack.Dockerfile.based-on="https://github.com/jlesage/docker-nginx-proxy-manager"

# don't need these variables in the running container
ENV NGINX_PROXY_MANAGER_BASE=
#ENV HEALTHCHECK_SCRIPT=
ENV IOTSTACK_ENTRY_POINT=

# EOF
