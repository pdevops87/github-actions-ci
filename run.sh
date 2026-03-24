if [ -z "${URL}" ]; then
 echo Input Github Organization is missing
 exit 1;
fi

if [ -z "${TOKEN}" ]; then
  echo Input Github runner token is missing
  exit 1;
fi

if [ -z "${NAME}" ]; then
  echo Input Github runner label is missing
  exit 1;
fi
./config.sh --unattended --url ${URL} --token ${TOKEN} --name ${NAME} --replace

./run.sh