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
        "models": [
            "kjzl6hvfrbw6c8civefnmbthyqz128oajo8rne47t7imp3dziakunm9tkvx2dnz",
            "kjzl6hvfrbw6c9dlsodj06c32xl8k86v0730l85rcd660ky7j68bv47pgpzqdq4",
            "kjzl6hvfrbw6c7tw0e3b7k46a7j8d18lsdku5bv8olullgdu75wgixlxr7mrz6r",
            "kjzl6hvfrbw6canerjq1olk5zyyjmes43dj8v0exyq0sbi17v4cxlpmfk2sking"
        ]
    }
}