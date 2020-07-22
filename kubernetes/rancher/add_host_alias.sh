kubectl -n cattle-system patch  deployments cattle-cluster-agent --patch '{
    "spec": {
        "template": {
            "spec": {
                "hostAliases": [
                    {
                        "hostnames":
                        [
                            "rancher.sfkj.sit"
                        ],
                            "ip": "172.24.19.164"
                    }
                ]
            }
        }
    }
}'


kubectl -n cattle-system patch  daemonsets cattle-node-agent --patch '{
    "spec": {
        "template": {
            "spec": {
                "hostAliases": [
                    {
                        "hostnames":
                        [
                            "rancher.sfkj.sit"
                        ],
                            "ip": "172.24.19.164"
                    }
                ]
            }
        }
    }
}'


