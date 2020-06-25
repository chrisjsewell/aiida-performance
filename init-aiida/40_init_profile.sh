#!/bin/bash
set -e

rm -f "/opt/.initialised" || true

SCRIPT_DIR="$(dirname $(realpath $0))"

echo "Waiting for postgres connection"
timeout 30s bash -c "until ${SCRIPT_DIR}/test_connection.py; do echo -n .; sleep 1; done"

echo "Setting up database"
# we don't run quicksetup here because we have already created the database
export AIIDA_PATH="/home/${NB_USER}/.aiida"
# TODO only allow error if its for existing profile, but should fail otherwise
verdi setup --config "${SCRIPT_DIR}/profile_${AIIDA_BACKEND}.yaml" --non-interactive || true

echo "Adding local computer"
# TODO move to ansible role?
# TODO only allow error if its for existing computer, but should fail otherwise
verdi computer setup --config "${SCRIPT_DIR}/computer_local.yaml" --work-dir "/home/${NB_USER}/work-dir" --non-interactive || true
verdi computer configure local localhost --non-interactive --safe-interval=0
# verdi computer test localhost

echo "Adding local code"
verdi code setup -L add --on-computer --computer=localhost -P arithmetic.add --remote-abs-path=/bin/bash --non-interactive || true

# change rabbitmq to host on docker network
# TODO replace when https://github.com/aiidateam/aiida-core/pull/4118 merged
file_path="${AIIDA_PKG:-"/opt/venv/lib/python3.6/site-packages/aiida"}/manage/external/rmq.py"
if [[ -f ${file_path} ]]; then
    echo "Changing rabbitmq host"
    sed -i "s/amqp:\/\/127.0.0.1/amqp:\/\/${RMQHOST:-messaging}/g" "${file_path}"
fi

# TODO I tried using `sudo -u ${NB_USER} verdi` but had issues
chown -R ${NB_USER}:${NB_USER} "/home/${NB_USER}/"

# if this file is present then the container has finished initialising
echo "READY!" > "/opt/.initialised"
