# README

```console

docker-compose up --build --detach

docker exec aiida-core timeout 30s bash -c \
    'until [ -f /opt/.initialised ] 2> /dev/null; do echo -n .; sleep 1; done'

export TEST_NAME=create_nodes

docker exec --user aiida aiida-core \
    /usr/bin/time -f "${TEST_NAME}: %e" -o /home/aiida/outputs/run_times.yml -a \
    py-spy record --subprocesses -f raw -o /home/aiida/outputs/${TEST_NAME}.prof -- \
    verdi run tests/${TEST_NAME}.py

docker-compose down -v

docker run -it --rm --name flamegraph -v "$PWD/plotting":/usr/src/myapp -w /usr/src/myapp perl:5.20 perl flamegraph.pl --inverted --title ${TEST_NAME} outputs/${TEST_NAME}.prof > outputs/${TEST_NAME}.svg
```

<https://github.com/stephanlindauer/docker-compose-updater>
