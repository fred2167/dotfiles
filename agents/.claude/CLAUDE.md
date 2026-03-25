# This is my personal preference for claude agent

 - all command references should be ran at the lowest folder tree that contained all changed files

 ## General Guidance
 - avoid compound commands. "Never chain commands with &&, ||, or ; operators. Run them as separate bash calls instead."
   Wrong: cd controller; bazel test ...
   Right: cd controller (first call)
          bazel test ... (second call)

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

## Explain Code
1. **Start with an analogy**: Compare the code to something from everyday life
2. **Draw a diagram**: provide a mermaid diagram in a markdown file
3. **Walk through the code**: Explain step-by-step what happens
4. **Highlight a gotcha**: What's a common mistake or misconception?
