seal file:
    cd {{invocation_directory()}} && kubeseal --controller-name sealed-secrets --controller-namespace sealed-secrets -f {{file}}.yaml -w {{file}}.sealed.yaml

seal-cluster-wide file:
    cd {{invocation_directory()}} && kubeseal --scope cluster-wide --controller-name sealed-secrets --controller-namespace sealed-secrets -f {{file}}.yaml -w {{file}}.sealed.yaml

shutdown:
    ssh pi@ethernode3.local 'sudo shutdown now'
    ssh pi@ethernode2.local 'sudo shutdown now'
    ssh pi@ethernode1.local 'sudo shutdown now'