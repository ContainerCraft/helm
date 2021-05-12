#!/bin/bash -x
kubectl patch deploy -n kong gateway-kong --patch '{
  "spec": {
    "template": {
      "spec": {
        "containers": [
          {
            "name": "proxy",
            "env": [
              {
                "name": "KONG_STREAM_LISTEN",
                "value": "0.0.0.0:2222"
              }
            ],
            "ports": [
              {
                "containerPort": 2222,
                "name": "ssh9000",
                "protocol": "TCP"
              }
            ]
          }
        ]
      }
    }
  }
}'

kubectl patch service -n kong gateway-kong-proxy --patch '{
  "spec": {
    "ports": [
      {
        "name": "ssh2222",
        "port": 2222,
        "protocol": "TCP",
        "targetPort": 2222
      }
    ]
  }
}'
