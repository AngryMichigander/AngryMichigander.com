# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Hugo static site generator project for "The Angry Michigander" blog. The site uses the Lynx theme (github.com/jpanther/lynx) via Hugo modules.

## Development Commands

- **Local development**: `hugo server -D` (serves locally with drafts)
- **Build for production**: `hugo --minify` (outputs to `public/` directory)
- **Build regular**: `hugo` (outputs to `public/` directory)

## Architecture

- **Framework**: Hugo static site generator with Go modules
- **Theme**: Lynx theme (github.com/jpanther/lynx v1.4.0) imported as Hugo module
- **Configuration**: hugo.yaml (main config file)
- **Content**: Markdown files in `content/` directory
- **Static assets**: `static/` directory for static files
- **Build output**: `public/` directory (generated, not tracked in git)

## Key Files and Directories

- `hugo.yaml` - Main Hugo configuration
- `go.mod` - Go module dependencies for Hugo modules
- `content/` - Markdown content files
- `archetypes/` - Content templates (default.md, post.md)
- `layouts/partials/` - Custom layout overrides
- `static/` - Static assets
- `assets/` - Source assets (CSS, images)

## CI/CD

The project has dual CI/CD setup:
- **GitHub Actions**: `.github/workflows/` (ubuntu-latest runner)
- **Forgejo Actions**: `.forgejo/workflows/` (self-hosted runner)

Both include build and deploy workflows that:
1. Check out code with submodules
2. Set up Hugo extended version
3. Build with `hugo --minify`
4. Upload artifacts to `public/` directory

## Forgejo Integration

This project uses Forgejo for source control. Use the `tea` CLI tool (https://gitea.com/gitea/tea) for Forgejo operations instead of `gh` CLI:

- **Setup**: `tea login add` (first-time setup)
- **List pull requests**: `tea pulls` or `tea pulls list`
- **Create pull request**: `tea pulls create`
- **View pull request**: `tea pulls [PR index]`
- **Merge pull request**: `tea pulls merge [PR index]`
- **List issues**: `tea issues` or `tea issues list`
- **Create issue**: `tea issues create`
- **View issue**: `tea issues [issue index]`

Always prefer `tea` commands over `gh` commands when working with this repository's Forgejo instance.

## Theme Customization

The Lynx theme is used via Hugo modules. Custom overrides can be placed in:
- `layouts/` - Layout overrides
- `assets/css/custom.css` - Custom CSS
- `static/` - Static file overrides

## Content Creation

Use archetypes for new content:
- `archetypes/default.md` - Default content template
- `archetypes/post.md` - Blog post template with extensive frontmatter options

Create new posts with: `hugo new posts/my-post.md`