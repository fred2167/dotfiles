# This is my personal preference for claude agent

 - all command references should be ran at the lowest folder tree that contained all changed files

## Go Monerepo
 - never change BUILD.bazel unless instructed by user explicitly. Relay on the command 'gazelle' to change build files
 - always run 'bazel test', 'ufmt', 'gazelle', and 'coverage', 'glint --diff' after changing the files

## Queryrunner
 - always use a general subagent in the background with bypassPermissions mode.
 - fetch schema first and always run query with specific field names. Never use 'SELECT *'.
 - save the raw results in /tmp/*-raw and the parsed output in /tmp/*-clean. Parse the data with 'jq' first, fallback to 'python' when needed.

## Kafka Schema Lookup
 - Best source for Avro schema files: Sourcegraph repo `uber-code/data-authored-schemas` under `production/hp/<topic-path>/<topic-name>.avsc`
 - Schema path convention: topic `hp-foo-bar-baz` maps to `production/hp/foo/bar/baz/hp-foo-bar-baz.avsc`
 - Go monorepo mirror: `third_party/schema-service-repo/schemas/` has BUILD.bazel with heatpipe rules; the `.avsc` is fetched at build time from Artifactory (requires auth)
 - Generated Go import path: `heatpipe/<topic-path>` (e.g. `heatpipe/connected/vehicles/vehicle/events`)
 - UI tools: Databook (`databook.uberinternal.com`) and Kafka Portal (`kafka.uberinternal.com`) for browsing schemas
 - Schema Service REST API is the programmatic source of truth (via cerberus port-forward)
 - No supported Kafka MCP server exists for schema lookups
