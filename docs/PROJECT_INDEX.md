# The Angry Michigander - Project Documentation Index

**Project Type**: Hugo Static Site Generator
**Theme**: Lynx v1.4.0 (Hugo Module)
**Repository**: github.com/AngryMichigander/angrymichigander.com
**Build System**: Hugo Extended with Go Modules
**Deployment**: AWS S3 via Forgejo Actions

---

## 📚 Table of Contents

- [Project Overview](#project-overview)
- [Architecture](#architecture)
- [Directory Structure](#directory-structure)
- [Configuration](#configuration)
- [Content Management](#content-management)
- [Theme Integration](#theme-integration)
- [Build & Deployment](#build--deployment)
- [Development Workflow](#development-workflow)
- [Customization](#customization)
- [CI/CD Pipeline](#cicd-pipeline)
- [Reference Documentation](#reference-documentation)

---

## Project Overview

### Purpose
Personal blog platform for "The Angry Michigander" featuring opinions and commentary.

### Technology Stack
- **Static Site Generator**: Hugo (latest extended)
- **Theme Framework**: Lynx v1.4.0
- **Module System**: Go 1.24.4
- **Deployment**: AWS S3 + CloudFront (assumed)
- **CI/CD**: Forgejo Actions (self-hosted runner)
- **Version Control**: Forgejo (with GitHub backup)

### Key Features
- Emoji support enabled
- Custom CSS styling
- Author profile with links
- Unsafe HTML rendering (Goldmark)
- Syntax highlighting with external CSS classes
- Taxonomies disabled (simplified structure)

---

## Architecture

### Hugo Module Architecture
```
angrymichigander (root)
├── Hugo Core (static site generator)
├── Go Modules (dependency management)
└── Lynx Theme (imported module)
    └── github.com/jpanther/lynx v1.4.0
```

### Build Pipeline
```
Source (Markdown + Config)
    ↓
Hugo Build Process
    ↓
Static Assets (public/)
    ↓
S3 Deployment
    ↓
CloudFront Distribution (assumed)
```

### Theme Integration Pattern
- **Module-based**: Theme imported via Go modules (not git submodules)
- **Override Capability**: Local overrides in `layouts/` and `assets/`
- **Configuration**: Theme params in `hugo.yaml`

---

## Directory Structure

### Root Level
```
/home/user/dev/angrymichigander/
├── .forgejo/           # Forgejo CI/CD workflows
├── .git/               # Git repository
├── .gitignore          # Git ignore patterns
├── archetypes/         # Content templates
├── assets/             # Source assets (images, CSS)
├── CLAUDE.md           # AI assistant instructions
├── go.mod              # Go module dependencies
├── go.sum              # Go module checksums
├── hugo.yaml           # Main Hugo configuration
└── README.md           # Project readme
```

### Key Directories

#### `/archetypes/`
Content template definitions for `hugo new` command.
- `default.md` - Default content template with frontmatter

#### `/assets/`
Source assets processed by Hugo Pipes.
- `css/custom.css` - Custom CSS overrides
- `author.png` - Author profile image
- `COLOURBOX38167690.eps` - Vector graphic source

#### `/.forgejo/workflows/`
CI/CD pipeline definitions for Forgejo Actions.
- `deploy.yml` - S3 deployment workflow

#### `/public/` (generated, gitignored)
Build output directory containing static site files.

---

## Configuration

### Main Config: `hugo.yaml`

**Module Configuration**:
```yaml
module:
  imports:
    - path: github.com/jpanther/lynx
```

**Site Settings**:
- **Title**: "The Angry Michigander"
- **Emoji**: Enabled
- **Disabled Kinds**: taxonomy, term (simplified structure)

**Author Configuration**:
```yaml
params:
  author:
    name: The Angry Michigander
    headline: Just a Michigander who has opinions
    image: author.png
    links:
      - link:
          href: 'https://cheatingchelsea.com'
          text: Cheating Chelsea Smallwood
```

**Markup Settings**:
- **Goldmark Renderer**: Unsafe HTML enabled
- **Syntax Highlighting**: External CSS classes (noClasses: false)

### Go Module Config: `go.mod`

```go
module github.com/AngryMichigander/angrymichigander.com
go 1.24.4
require github.com/jpanther/lynx v1.4.0 // indirect
```

---

## Content Management

### Archetypes

#### Default Archetype (`archetypes/default.md`)
```markdown
---
date: '{{ .Date }}'
draft: true
title: '{{ replace .File.ContentBaseName "-" " " | title }}'
---
```

### Content Creation Workflow
1. Create new content: `hugo new posts/my-post.md`
2. Edit content in generated file
3. Update frontmatter (change `draft: false` when ready)
4. Build site: `hugo` or `hugo --minify`

### Content Organization
- Content files stored in `content/` directory (not present in minimal setup)
- Posts typically in `content/posts/`
- Pages in `content/` root or subdirectories

---

## Theme Integration

### Lynx Theme
- **Repository**: github.com/jpanther/lynx
- **Version**: v1.4.0
- **Integration**: Hugo Module (not submodule)
- **Documentation**: See theme repo for full feature set

### Theme Customization Hierarchy
1. **Local Overrides** (highest priority)
   - `layouts/` - Layout template overrides
   - `assets/` - Asset overrides

2. **Configuration** (medium priority)
   - `hugo.yaml` - Theme parameters

3. **Theme Defaults** (lowest priority)
   - Module-imported theme files

### Current Customizations
- **CSS**: `assets/css/custom.css` - Minimal overrides
- **Author Image**: `assets/author.png` - Custom profile image
- **Config**: Author profile and link customization

---

## Build & Deployment

### Local Development
```bash
# Start development server with drafts
hugo server -D

# Start development server without drafts
hugo server

# Access at: http://localhost:1313
```

### Production Build
```bash
# Build with minification
hugo --minify

# Build without minification
hugo

# Output directory: public/
```

### Build Output
- **Directory**: `public/`
- **Contents**: Complete static site (HTML, CSS, JS, assets)
- **Git Status**: Ignored (in `.gitignore`)

---

## Development Workflow

### Recommended Workflow
1. **Start Development Server**: `hugo server -D`
2. **Create Content**: `hugo new posts/article-name.md`
3. **Edit Content**: Modify in `content/posts/article-name.md`
4. **Preview**: View at http://localhost:1313
5. **Finalize**: Set `draft: false` in frontmatter
6. **Build**: `hugo --minify`
7. **Commit**: Git commit and push to main
8. **Deploy**: Automatic via Forgejo Actions

### Version Control
- **Primary**: Forgejo (self-hosted)
- **Tool**: `tea` CLI for Forgejo operations
- **Backup**: GitHub (assumed)

### Key Commands
```bash
# Forgejo PR management
tea pulls list                  # List PRs
tea pulls create                # Create PR
tea pulls merge [PR index]      # Merge PR

# Forgejo issue management
tea issues list                 # List issues
tea issues create               # Create issue
```

---

## Customization

### CSS Customization
**File**: `assets/css/custom.css`

Override theme styles by adding CSS rules. Hugo Pipes will process and bundle with theme CSS.

### Layout Customization
Create files in `layouts/` matching theme structure:
- `layouts/_default/` - Default templates
- `layouts/partials/` - Partial templates
- `layouts/shortcodes/` - Custom shortcodes

### Static Assets
Place static files in `static/` directory:
- `static/images/` - Static images
- `static/files/` - Downloadable files
- Files copied directly to `public/` without processing

### Theme Parameters
Customize in `hugo.yaml` under `params:` section. See Lynx theme documentation for available parameters.

---

## CI/CD Pipeline

### Forgejo Actions Workflow

**File**: `.forgejo/workflows/deploy.yml`

**Trigger**: Push to `main` branch

**Runner**: Self-hosted

**Steps**:
1. **Checkout**: Clone repository with submodules
2. **Setup Hugo**: Install Hugo extended (latest)
3. **Build**: Execute `hugo --minify`
4. **Configure AWS**: Set credentials from secrets
5. **Deploy**: Sync `public/` to S3 bucket

**Required Secrets**:
- `AWS_ACCESS_KEY_ID` - AWS access key
- `AWS_SECRET_ACCESS_KEY` - AWS secret key
- `S3_BUCKET_NAME` - Target S3 bucket

**Deployment Strategy**:
- **Method**: `aws s3 sync` with `--delete` flag
- **Region**: us-east-1
- **Target**: S3 bucket (name in secrets)

---

## Reference Documentation

### Official Documentation
- **Hugo**: https://gohugo.io/documentation/
- **Lynx Theme**: https://github.com/jpanther/lynx
- **Go Modules**: https://go.dev/ref/mod
- **Forgejo**: https://forgejo.org/docs/
- **Tea CLI**: https://gitea.com/gitea/tea

### Project Documentation
- `CLAUDE.md` - AI assistant guidelines (hugo.yaml:4-34, go.mod:1-6)
- `README.md` - Project overview
- This file - Comprehensive project documentation

### Key Files Reference
- **Config**: `hugo.yaml:1-34`
- **Dependencies**: `go.mod:1-6`
- **CI/CD**: `.forgejo/workflows/deploy.yml:1-37`
- **Archetype**: `archetypes/default.md:1-6`
- **Custom CSS**: `assets/css/custom.css:1-2`

---

## Maintenance Notes

### Hugo Updates
```bash
# Update Hugo modules
hugo mod get -u

# Update specific module
hugo mod get -u github.com/jpanther/lynx

# Tidy dependencies
hugo mod tidy
```

### Theme Updates
```bash
# Update to latest Lynx version
hugo mod get -u github.com/jpanther/lynx

# Update to specific version
hugo mod get github.com/jpanther/lynx@v1.5.0
```

### Troubleshooting
- **Module errors**: Run `hugo mod tidy`
- **Build errors**: Check Hugo version compatibility
- **Theme issues**: Verify module import in `hugo.yaml`
- **Deployment failures**: Check AWS credentials and S3 bucket permissions

---

**Last Updated**: 2025-10-14
**Documentation Version**: 1.0.0
