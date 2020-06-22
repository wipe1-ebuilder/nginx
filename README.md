## Reverse proxy to serve web artifact from local machine
### setup web artifact repository locally
`./artifacts/setup_artifacts_locally.sh`

### run reverse proxy + artifacts locally
`docker-compose up -d reverse_proxy_git`

### run reverse proxy only
`docker-compose up -d reverse_proxy`

### run reverse proxy
`docker-compose down`
