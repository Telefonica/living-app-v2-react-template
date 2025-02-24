# Mock Server

Simple HTTP mock server for component testing:
- The mock’s behaviour is configurable using the HTTP API.
- There are available some steps as part of the catalog to manage the behaviour of the mock and get information about the status of queues of requests and responses.

Reference:

https://qacdco.d-consumer.com/toolium-telefonica-docs/toolium_cli.html#dynamic-http-mock-server
https://qacdco.d-consumer.com/toolium-telefonica-docs/_modules/toolium_telefonica/behave/steps/tools/mocks/mock.html

## Deploy:

```
docker login dockerhub.hi.inet

docker build -t dockerhub.hi.inet/haac/la/qa-simple-mock:latest .

docker push dockerhub.hi.inet/haac/la/qa-simple-mock:latest
```

## Use in local:

It's possible to up a mock using directly toolium:

```
toolium mock-server
```

Check more options with:

```
toolium mock-server -h
```

In order to use the docker version:

```
docker run -d -p 8889:8889 --name qa-simple-mock dockerhub.hi.inet/haac/la/qa-simple-mock:latest
```

Port 8889 is used by the mock, you can setup any forward port instead of 8889.

To use the local docker version, first build the docker and then run it:

```
docker build . -t qa-simple-mock:latest
docker run -d -p 8889:8889 --name qa-simple-mock qa-simple-mock:latest
```

Get logs with the command:

```
docker logs qa-simple-mock -f
```

## Use remote simple mock:

An instance of simple mock is available in the URL:

```
https://qa-simple-mock.apps.ocp-epg.tid.es
```

To use this version of the mock it's necessary to rewrite the mock url after the MockServerUtils creation:

```
context.mock_server.mock_url = "https://qa-simple-mock.apps.ocp-epg.tid.es"
```
