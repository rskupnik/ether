seal file:
    cd {{invocation_directory()}} && kubeseal --scope namespace-wide --controller-name sealed-secrets --controller-namespace sealed-secrets -f {{file}}.yaml -w {{file}}.sealed.yaml