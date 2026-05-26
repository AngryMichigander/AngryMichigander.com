# The Angry Michigander

Personal blog platform built with Hugo and the Lynx theme.

## Quick Start

```bash
# Development server with drafts
hugo server -D

# Production build
hugo --minify
```

## Documentation

📚 **Comprehensive documentation available in `docs/`:**

- **[docs/README.md](docs/README.md)** - Documentation index and overview
- **[docs/QUICK_REFERENCE.md](docs/QUICK_REFERENCE.md)** - Fast command reference
- **[docs/DEVELOPMENT_GUIDE.md](docs/DEVELOPMENT_GUIDE.md)** - Complete development guide
- **[docs/PROJECT_INDEX.md](docs/PROJECT_INDEX.md)** - Full project documentation

## Technology Stack

- **Static Site Generator**: Hugo (Extended)
- **Theme**: [Lynx](https://github.com/jpanther/lynx) v1.4.0
- **Deployment**: AWS S3 via Forgejo Actions
- **Version Control**: Forgejo (with `tea` CLI)

## Key Commands

```bash
# Content creation
hugo new posts/my-post.md

# Local preview
hugo server -D

# Production build
hugo --minify

# Module management
hugo mod get -u              # Update all modules
hugo mod tidy               # Clean dependencies
```

## CI/CD

Automatic deployment to AWS S3 on push to `main` branch via Forgejo Actions.

## Network footer

This site is the hub for the AngryMichigander Network. The footer + `/network/` page are
generated from `data/network.json`, which is synced from the
`vendor/network-manifest` git submodule (pinned to a tagged release).

### Refreshing network data

```bash
git submodule update --remote vendor/network-manifest   # bump to latest manifest commit on main
git -C vendor/network-manifest checkout <tag>           # or pin to a specific tag
make sync-network-data                                  # copy network.json into data/
make verify-footer-override                             # build + sanity-check
```

### Upgrading the lynx theme

Edit the `replace` directive in `go.mod` to point at the new fork commit, then:

```bash
go mod tidy
make verify-footer-override
```

Do **not** use `hugo mod get -u` — the `replace` directive will mask any upstream
changes, so module updates have to flow through editing `go.mod` explicitly.

### Build note

The submodule lives under `vendor/network-manifest`, which triggers Go's vendoring
mode. The repo's `Makefile` sets `GOFLAGS=-mod=mod` for that reason; if you invoke
`hugo` directly, prefix it with `GOFLAGS=-mod=mod` (or `export` it in your shell).

## Getting Help

- See [docs/QUICK_REFERENCE.md](docs/QUICK_REFERENCE.md) for common tasks
- See [docs/DEVELOPMENT_GUIDE.md](docs/DEVELOPMENT_GUIDE.md) for detailed setup
- See [CLAUDE.md](CLAUDE.md) for AI assistant guidelines

## License

Personal project - All rights reserved.
