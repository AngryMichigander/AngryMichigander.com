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

## Getting Help

- See [docs/QUICK_REFERENCE.md](docs/QUICK_REFERENCE.md) for common tasks
- See [docs/DEVELOPMENT_GUIDE.md](docs/DEVELOPMENT_GUIDE.md) for detailed setup
- See [CLAUDE.md](CLAUDE.md) for AI assistant guidelines

## License

Personal project - All rights reserved.
