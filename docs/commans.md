#### Get `kubectl top` summary
```
$ kubectl top pod --use-protocol-buffers -A \
    | sed -E 's/-[[:alnum:]]{5,10}-[[:alnum:]]{5,10} //' \
    | awk 'BEGIN{old=""}{ if (old!=$2) {printf "\n%-15s %-25s \t%-8s %-8s ",$1, $2, $3, $4; old=$2} else printf "%-8s %-8s", $3, $4}' \
    > /tmp/cluster-resources.txt
```
