# {{ test_name | replace("_", " ") | replace("-", " ") | capitalize }}

## Profiling FlameGraph

```{raw} html
<div class="flamegraph">
```

```{raw} html
:file: {{ test_name }}.svg
```

```{raw} html
</div>
```

## Database Queries

```{raw} html
<div class="dataframe">
```

```{raw} html
:file: {{ test_name }}_queries.html
```

```{raw} html
</div>
```
