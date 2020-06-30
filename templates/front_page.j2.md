# {{ GIT_BRANCH }} (python {{ PYTHON_VERSION }}, {{ AIIDA_BACKEND }})

## Environment Data

Fact         | Value
-------------|-----------------------------------------------------------
Date         | {{ ansible_date_time.date }} {{ ansible_date_time.time }}
Machine      | {{ ansible_facts.machine }}
Kernel       | {{ ansible_facts.kernel_version }}
Processor    | {{ ansible_facts.processor }}
Cores        | {{ ansible_facts.processor_cores | int }}
Virtual CPUs | {{ ansible_facts.processor_vcpus | int }}

## Test Times

```yaml
{{ run_times }}
```

## Final Database Statistics

```{raw} html
<div class="dataframe">
```

```{raw} html
:file: final_indices.html
```

```{raw} html
</div>
```

## Test Outputs

```{toctree}
:glob:

*
```
