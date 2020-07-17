# vscode

## >= 0.0.8

`
docker run -d -p 8182:8080 -v "${PWD}:/home/coder" flaugere/vscode:0.0.8 --auth none
`

## < 0.0.8

HTTP authless :   
`
docker run -d -p 8444:8443 -v "${PWD}:/home/coder/project" flaugere/vscode:0.0.7 --allow-http --no-auth
`

HTTPS with auth :  
`
docker run -d -p 8444:8443 -v "${PWD}:/home/coder/project" flaugere/vscode:0.0.7
`
