{
    "anchor": {},
    "http-api": {
        "cors-allowed-origins": [
            ".*"
        ]
    },
    "ipfs": {
        "mode": "remote",
        "host": "${ipfs_host}"
    },
    "logger": {
        "log-level": 2,
        "log-to-files": false
    },
    "metrics": {
        "metrics-exporter-enabled": false,
        "metrics-port": 9090
    },
    "network": {
        "name": "${network_name}"
    },
    "node": {},
    "state-store": {
        "mode": "s3",
        "s3-bucket": "${ceramic_bucket}"
    },
    "indexing": {
        "allow-queries-before-historical-sync": true,
        "db": "sqlite:///ceramic/.ceramic/indexing.sqlite",
        "models": []
    }
}