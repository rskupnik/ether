seal file:
    cd {{invocation_directory()}} && kubeseal --controller-name sealed-secrets --controller-namespace sealed-secrets -f {{file}}.yaml -w {{file}}.sealed.yaml

seal-cluster-wide file:
    cd {{invocation_directory()}} && kubeseal --scope cluster-wide --controller-name sealed-secrets --controller-namespace sealed-secrets -f {{file}}.yaml -w {{file}}.sealed.yaml