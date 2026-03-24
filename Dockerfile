FROM                 docker.io/redhat/ubi9
RUN                  dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
RUN                  dnf install -y docker-ce-cli libicu
RUN                  dnf clean all
RUN                  groupadd  docker || true
RUN                  useradd -m runner
RUN                  usermod -aG docker runner
RUN                  mkdir /home/runner/actions-runner
RUN                  curl -o actions-runner-linux-x64-2.332.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.332.0/actions-runner-linux-x64-2.332.0.tar.gz
RUN                  tar xzf ./actions-runner-linux-x64-2.332.0.tar.gz -C /home/runner/actions-runner
# copy in runner user so ownership has to be changed
COPY                 --chown=runner:runner run.sh /run.sh
# provide permissions to execute all files in non root user
RUN                  chmod +x /run.sh
USER                 runner
WORKDIR              /home/runner/actions-runner
ENTRYPOINT           ["bash", "/run.sh"]










