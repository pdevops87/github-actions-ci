# github-actions-ci
build stage doesn't require for NodeJs,Python
JAVA,Go lang
* github action runner is a container, inside a container again we are running a docker container so required .sock permissions

** environment in github actions:
=================================
* labauto roboshop-app-repos-env-create





- name: Grant access to Docker Socket
  run: |
  # Grant read and write permissions to everyone for the socket channel
  sudo chmod 666 /var/run/docker.sock