# Scanning the API using Mayhem

Before starting, make sure the Mayhem `mapi` CLI is installed
on your system following our installation guide:

 https://app.mayhem.security/docs/api-testing/getting-set-up/installation/

## 1. Launching the app with Docker Compose:

The application (client and daemon) can both be launched, along with their
dependencies (redis, postgres) with Docker Compose.

```bash
docker compose up --build
```

Client: http://localhost:4200

Daemon: http://localhost:3001

## 2. API Specification

Mayhem is built around OpenAPI 3 specifications to drive runs for API
scanning. I could not find an OpenAPI spec in the repository, nor could
I find a mechanism for generating an OpenAPI spec inside the amorphic
framework (though it may be possible as a future feature enhancement).

Without a spec, I chose to generate one from an HTTP Archive.

First, I accessed the client dashboard (http://localhost:4200/dashboard)
and tried to invoke every REST API request I could find.

I exported this to an HTTP Archive file from the Chrome network tab in
developer tools.

I converted this file into an OpenAPI spec using the Mayhem `mapi` CLI:

```bash
mapi convert har ./amorphic.har > openapi.json
```

The converted spec was close, but needed some adjustments.

I opened the spec up in the interactive swagger editor (https://editor-next.swagger.io/)
and made some adjustments so that it looked like the API under test.

## 3. Scanning the API:



With a way to run the application stack and an API spec, we are ready to run!

This is my run command:

```bash
mapi run amorphic-daemon \
  auto \
  ./openapi.yaml \
  --url http://localhost:3001 \
  --interactive
```
