---
name: Go coding and testing conventions
description: How the user writes Go code, tests, and organizes projects — derived from gha-runner-watcher and gha-runner-vpa repos
type: feedback
---

## Testing

- **Table-driven tests** with `testify/require` (fatal) and `testify/assert` (non-fatal)
- Test struct pattern: `name string`, `setup func(...)`, `assertion func(t, ...)` closures
- Loop: `for _, tt := range tests { t.Run(tt.name, func(t *testing.T) { ... }) }`
- **Handwritten stub mocks** in separate `stub_test.go` files — no mockgen or mock libraries
- Stub pattern: struct with function fields (`QueryFn`, `QueryComputeResourcesFn`), nil-safe defaults
- `TestMain()` for suite-level setup (e.g., envtest), `t.Cleanup()` for per-test resource teardown
- `require.NoError` for setup steps, `assert.Equal`/`assert.True` for outcome checks

**Why:** User strongly prefers table-driven tests for readability and consistency. Handwritten stubs keep test dependencies minimal and explicit.

**How to apply:** Always write table-driven tests with setup/assertion closures. Put test doubles in `stub_test.go`. Use testify, never raw `if` comparisons in tests.

## Code Style

- Error wrapping: `fmt.Errorf("descriptive context: %w", err)` — never bare errors
- Structured logging via `log/slog` with key-value pairs, not `fmt.Sprintf`
- Short receiver names: single letter (`w *Watcher`, `r *Reconciler`, `c *Client`)
- Constructors return interfaces; concrete types are unexported
- Env var config with sensible defaults, parsed in `LoadConfig()` functions with validation
- `internal/` package convention for encapsulation
- Domain-driven package layout (separate packages per concern)
- Standard library first — `net/http`, no router frameworks (chi, mux, etc.)
- Constants grouped at top of file
- Early returns, fail fast

**Why:** Clean, pragmatic Go — minimal dependencies, explicit over implicit, testable by design.

**How to apply:** Follow these patterns in all Go code. Don't introduce frameworks or libraries without being asked.

## Git Commits

- Conventional commits: `feat:`, `fix:`, `test:`, `refactor:`, `docs:`, `chore:`
- Optional scope in parens: `test(reconciler):`, `feat(prometheus):`
- Concise messages — one line unless multi-line is warranted

**Why:** Consistent commit history across all repos.

**How to apply:** Use this format for all commits in Go projects.
