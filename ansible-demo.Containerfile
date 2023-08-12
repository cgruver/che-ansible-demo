FROM registry.access.redhat.com/ubi9/ubi-minimal
ARG USER_HOME_DIR="/home/user"
ARG WORK_DIR="/projects"
ENV HOME=${USER_HOME_DIR}
ENV BUILDAH_ISOLATION=chroot
ENV PATH=${PATH}:/projects/bin
COPY --chown=0:0 entrypoint.sh /
RUN microdnf --disableplugin=subscription-manager install -y openssl compat-openssl11 libbrotli git tar gzip zip xz unzip which shadow-utils bash zsh vi wget jq podman buildah skopeo python3-pip python3-devel; \
  microdnf update -y ; \
  microdnf clean all ; \
  mkdir -p ${USER_HOME_DIR} ; \
  mkdir -p ${WORK_DIR} ; \
  mkdir -p /usr/local/bin ; \
  setcap cap_setuid+ep /usr/bin/newuidmap ; \
  setcap cap_setgid+ep /usr/bin/newgidmap ; \
  mkdir -p ${HOME}/.config/containers ; \
  mkdir ${HOME}/proc ; \
  (echo "[containers]";echo "netns=\"host\"";echo "volumes=[";echo "  \"${HOME}/proc:/proc:rw\"";echo "]") > ${HOME}/.config/containers/containers.conf ; \
  touch /etc/subgid /etc/subuid ; \
  chmod -R g=u /etc/passwd /etc/group /etc/subuid /etc/subgid ; \
  echo user:20000:65536 > /etc/subuid  ; \
  echo user:20000:65536 > /etc/subgid ; \
  pip3 install ansible-navigator ; \
  pip3 install ansible ; \
  pip3 install ansible-lint ; \
  chgrp -R 0 /home ; \
  chmod +x /entrypoint.sh ; \
  chmod -R g=u /home ${WORK_DIR}
  USER 10001
WORKDIR ${WORK_DIR}
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "tail", "-f", "/dev/null" ]
