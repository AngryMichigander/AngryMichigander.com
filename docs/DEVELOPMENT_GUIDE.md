# Development Guide - The Angry Michigander

Comprehensive guide for developers working with this Hugo site.

---

## Table of Contents

- [Setup](#setup)
- [Development Environment](#development-environment)
- [Content Creation](#content-creation)
- [Theme Customization](#theme-customization)
- [Testing](#testing)
- [Deployment](#deployment)
- [Advanced Topics](#advanced-topics)
- [Troubleshooting](#troubleshooting)

---

## Setup

### Prerequisites

**Required**:
- Hugo Extended v0.112.0+ (latest recommended)
- Go 1.18+ (for Hugo modules)
- Git
- AWS CLI (for manual deployments)
- Tea CLI (for Forgejo operations)

**Optional**:
- Text editor with Hugo support (VS Code, Vim, etc.)
- Image optimization tools (ImageMagick, etc.)

### Installation

#### Hugo Extended
```bash
# macOS (Homebrew)
brew install hugo

# Linux (Snap)
snap install hugo

# Windows (Chocolatey)
choco install hugo-extended

# Verify installation
hugo version
# Should show: hugo vX.XXX.X+extended
```

#### Tea CLI
```bash
# Install tea
go install gitea.com/gitea/tea@latest

# Configure for Forgejo
tea login add
# Follow prompts to add Forgejo instance
```

### Project Setup
```bash
# Clone repository
git clone <forgejo-url>/angrymichigander.git
cd angrymichigander

# Initialize Hugo modules
hugo mod get

# Verify setup
hugo version
hugo mod graph
```

---

## Development Environment

### Local Development Server

#### Basic Usage
```bash
# Start server with drafts
hugo server -D

# Start without drafts (production preview)
hugo server

# Custom port
hugo server -p 8080

# Bind to specific address
hugo server --bind 0.0.0.0 --port 8080
```

#### Server Options
```bash
# Fast render mode (skip some processing)
hugo server --disableFastRender=false

# Enable live reload
hugo server --liveReloadPort 1313

# Navigate to future content
hugo server --buildFuture

# Show expired content
hugo server --buildExpired
```

### Development Workflow

#### Standard Workflow
1. **Start server**: `hugo server -D`
2. **Create content**: `hugo new posts/article.md`
3. **Edit content**: Modify files, server auto-reloads
4. **Preview**: Check localhost:1313
5. **Finalize**: Set `draft: false`
6. **Build**: `hugo --minify`
7. **Test**: Review `public/` output
8. **Commit**: Git add, commit, push
9. **Deploy**: Automatic via CI/CD

#### Feature Branch Workflow
```bash
# Create feature branch
git checkout -b feature/new-article

# Make changes
hugo new posts/my-article.md
# ... edit content ...

# Preview
hugo server -D

# Commit
git add content/posts/my-article.md
git commit -m "Add article: My Article"

# Push
git push origin feature/new-article

# Create PR
tea pulls create --base main --head feature/new-article \
  --title "Add new article" \
  --description "Article about topic"

# After review, merge via tea or Forgejo UI
tea pulls merge [PR-INDEX]
```

---

## Content Creation

### Content Types

#### Blog Posts
```bash
# Create new post
hugo new posts/my-post.md

# Output: content/posts/my-post.md
```

**Generated Template** (`archetypes/default.md`):
```markdown
---
date: '2025-10-14T10:00:00-04:00'
draft: true
title: 'My Post'
---

Your content here...
```

#### Pages
```bash
# Create about page
hugo new about.md

# Create nested page
hugo new about/team.md
```

### Frontmatter Reference

#### Required Fields
```yaml
date: '2025-10-14T10:00:00-04:00'  # Publication date
draft: false                        # Draft status
title: 'Article Title'              # Page title
```

#### Optional Fields (Lynx Theme)
```yaml
description: 'Article summary'      # Meta description
tags: ['tag1', 'tag2']             # Content tags
categories: ['category']            # Content categories
author: 'Author Name'              # Override default author
slug: 'custom-url-slug'            # Custom URL
aliases: ['/old-url']              # URL redirects
featured_image: 'image.jpg'        # Featured image
weight: 10                         # Sort order
```

#### Lynx-Specific Parameters
```yaml
params:
  showDate: true                    # Show publication date
  showAuthor: true                  # Show author info
  showReadingTime: true             # Show reading time
  showWordCount: false              # Show word count
  showToc: true                     # Show table of contents
  showBreadcrumbs: true             # Show breadcrumb navigation
  showComments: false               # Show comments section
```

### Content Formatting

#### Markdown Syntax
```markdown
# Heading 1
## Heading 2
### Heading 3

**Bold text**
*Italic text*
~~Strikethrough~~

[Link text](https://example.com)
![Image alt](image.jpg)

- Bullet list item
1. Numbered list item

> Blockquote

`inline code`

```language
code block
```
```

#### Hugo Shortcodes
```markdown
{{< figure src="image.jpg" title="Caption" >}}

{{< youtube VIDEO_ID >}}

{{< tweet USER TWEET_ID >}}
```

#### HTML in Markdown
Enabled via `hugo.yaml` (`unsafe: true`):
```markdown
<div class="custom-class">
  Custom HTML content
</div>
```

---

## Theme Customization

### Lynx Theme Architecture

#### Override Hierarchy
1. **Local overrides** (`layouts/`, `assets/`)
2. **Site config** (`hugo.yaml` params)
3. **Theme defaults** (module)

### CSS Customization

#### Custom CSS File
**Location**: `assets/css/custom.css`

```css
/* Override theme variables */
:root {
  --color-primary: #1a73e8;
  --font-family-base: 'Inter', sans-serif;
}

/* Custom component styles */
.article-header {
  background: linear-gradient(to right, #667eea, #764ba2);
}

/* Responsive overrides */
@media (max-width: 768px) {
  .container {
    padding: 1rem;
  }
}
```

#### Hugo Pipes Processing
CSS in `assets/` is processed by Hugo Pipes:
- Minification
- PostCSS processing
- Source maps (dev mode)
- Fingerprinting (production)

### Layout Customization

#### Override Theme Layouts
Create matching file structure in `layouts/`:

```
layouts/
├── _default/
│   ├── baseof.html       # Base template
│   ├── single.html       # Single page template
│   └── list.html         # List page template
├── partials/
│   ├── header.html       # Header component
│   ├── footer.html       # Footer component
│   └── head.html         # Head section
├── posts/
│   └── single.html       # Post-specific template
└── index.html            # Homepage template
```

#### Example: Custom Header
**File**: `layouts/partials/header.html`
```html
<header class="site-header">
  <div class="container">
    <h1>{{ .Site.Title }}</h1>
    <nav>
      {{ range .Site.Menus.main }}
        <a href="{{ .URL }}">{{ .Name }}</a>
      {{ end }}
    </nav>
  </div>
</header>
```

### Static Assets

#### Static Files
**Location**: `static/` (create if needed)

Files copied directly to `public/` without processing:
```
static/
├── images/
│   └── logo.png
├── files/
│   └── document.pdf
└── favicon.ico
```

**Usage in templates**:
```html
<img src="/images/logo.png" alt="Logo">
<link rel="icon" href="/favicon.ico">
```

#### Processed Assets
**Location**: `assets/`

Files processed by Hugo Pipes:
```
assets/
├── css/
│   └── custom.css
├── js/
│   └── custom.js
└── images/
    └── hero.png
```

**Usage in templates**:
```html
{{ $css := resources.Get "css/custom.css" | minify | fingerprint }}
<link rel="stylesheet" href="{{ $css.RelPermalink }}">

{{ $img := resources.Get "images/hero.png" | fingerprint }}
<img src="{{ $img.RelPermalink }}" alt="Hero">
```

---

## Testing

### Local Testing

#### Build Testing
```bash
# Development build
hugo

# Production build
hugo --minify

# Check output
ls -la public/
```

#### Preview Testing
```bash
# Preview with production settings
hugo server --disableFastRender

# Test draft content
hugo server -D

# Test future content
hugo server --buildFuture
```

#### Validation
```bash
# Check for broken links (manual)
# Use browser dev tools or link checker

# Validate HTML (external tool)
# npm install -g html-validator-cli
html-validator --file=public/index.html

# Test accessibility (external tool)
# npm install -g pa11y-ci
pa11y-ci public/**/*.html
```

### Performance Testing

#### Build Performance
```bash
# Measure build time
time hugo --minify

# Template metrics
hugo --templateMetrics

# Template metrics with hints
hugo --templateMetrics --templateMetricsHints
```

#### Site Performance
```bash
# Lighthouse (via Chrome DevTools)
# Or use: npm install -g lighthouse
lighthouse https://your-site.com --view

# Page speed analysis
# Use: https://pagespeed.web.dev/
```

---

## Deployment

### Automatic Deployment (CI/CD)

#### Forgejo Actions Pipeline
**File**: `.forgejo/workflows/deploy.yml`

**Trigger**: Push to `main` branch

**Process**:
1. Checkout with submodules
2. Setup Hugo extended
3. Build: `hugo --minify`
4. Configure AWS credentials
5. Deploy: `aws s3 sync public/ s3://BUCKET --delete`

#### Monitoring Deployments
```bash
# Via Forgejo UI
# Navigate to: Repository → Actions

# Via git log
git log --oneline -n 10

# Check S3 deployment (manual)
aws s3 ls s3://YOUR-BUCKET-NAME --recursive
```

### Manual Deployment

#### Build and Deploy
```bash
# Build production site
hugo --minify

# Deploy to S3
aws s3 sync public/ s3://YOUR-BUCKET-NAME \
  --delete \
  --region us-east-1

# Invalidate CloudFront cache (if using)
aws cloudfront create-invalidation \
  --distribution-id YOUR-DIST-ID \
  --paths "/*"
```

#### Deployment Checklist
- [ ] All drafts finalized (`draft: false`)
- [ ] Local build successful (`hugo --minify`)
- [ ] Visual inspection of key pages
- [ ] Links tested
- [ ] Images optimized
- [ ] Git committed and pushed
- [ ] CI/CD pipeline successful
- [ ] Site live and accessible

---

## Advanced Topics

### Hugo Modules

#### Module Management
```bash
# List modules
hugo mod graph

# Update all modules
hugo mod get -u

# Update specific module
hugo mod get -u github.com/jpanther/lynx

# Update to specific version
hugo mod get github.com/jpanther/lynx@v1.5.0

# Clean module cache
hugo mod clean

# Verify modules
hugo mod verify

# Tidy go.mod
hugo mod tidy
```

#### Module Configuration
**File**: `hugo.yaml`
```yaml
module:
  imports:
    - path: github.com/jpanther/lynx
      disabled: false
      mounts:
        - source: layouts
          target: layouts
        - source: static
          target: static
```

### Performance Optimization

#### Build Optimization
```bash
# Enable caching
hugo --gc

# Parallel processing
hugo --parallel=4

# Disable live reload
hugo server --disableLiveReload
```

#### Asset Optimization
```yaml
# hugo.yaml
minify:
  minifyOutput: true
  tdewolff:
    html:
      keepWhitespace: false
    css:
      keepCSS2: false
    js:
      keepVarNames: false
```

#### Image Processing
```html
{{ $img := resources.Get "images/hero.jpg" }}
{{ $resized := $img.Resize "800x" }}
{{ $webp := $resized.Process "webp" }}
<img src="{{ $webp.RelPermalink }}" alt="Hero">
```

### Custom Shortcodes

#### Create Shortcode
**File**: `layouts/shortcodes/callout.html`
```html
<div class="callout callout-{{ .Get "type" }}">
  <strong>{{ .Get "title" }}</strong>
  {{ .Inner }}
</div>
```

**Usage in content**:
```markdown
{{< callout type="warning" title="Important" >}}
This is a warning message.
{{< /callout >}}
```

### Content Organization

#### Content Sections
```
content/
├── posts/           # Blog posts
│   ├── _index.md   # Section page
│   └── post-1.md
├── docs/            # Documentation
│   ├── _index.md
│   └── guide.md
└── about/           # About pages
    └── index.md
```

#### Taxonomies (Currently Disabled)
To enable taxonomies, remove from `hugo.yaml`:
```yaml
# Remove this section to enable
# disableKinds:
#   - taxonomy
#   - term
```

Then add taxonomy pages:
```
content/
├── tags/
│   └── _index.md
└── categories/
    └── _index.md
```

---

## Troubleshooting

### Common Issues

#### Module Resolution Errors
```bash
# Error: module not found
hugo mod tidy
hugo mod get -u

# Clear cache
hugo mod clean
rm -rf ~/.cache/hugo_cache
```

#### Build Failures
```bash
# Error: template not found
# Check theme module is loaded
hugo mod graph

# Error: resource not found
# Verify file exists in assets/ or static/
find . -name "filename"
```

#### Server Issues
```bash
# Port already in use
hugo server -p 8080

# Permission denied
# Check file permissions
ls -la

# No changes detected
# Restart server
# Disable fast render: hugo server --disableFastRender
```

#### Deployment Issues
```bash
# AWS credentials not configured
aws configure

# S3 access denied
# Check IAM permissions: s3:PutObject, s3:DeleteObject, s3:ListBucket

# Workflow fails
# Check Forgejo secrets are set
# Review workflow logs in Forgejo UI
```

### Debug Mode

#### Hugo Debug Output
```bash
# Verbose output
hugo --verbose

# Debug output
hugo --debug

# Log level
hugo --logLevel info

# Print paths
hugo --printPathWarnings

# Template debugging
hugo --templateMetrics --templateMetricsHints
```

#### Template Debugging
```html
<!-- Print variable -->
{{ printf "%#v" . }}

<!-- Debug context -->
{{ partial "debug.html" . }}
```

**File**: `layouts/partials/debug.html`
```html
<pre>{{ printf "%#v" . }}</pre>
```

---

## Resources

### Documentation
- [Hugo Documentation](https://gohugo.io/documentation/)
- [Lynx Theme](https://github.com/jpanther/lynx)
- [Hugo Modules](https://gohugo.io/hugo-modules/)
- [Go Templates](https://pkg.go.dev/text/template)

### Tools
- [Hugo Extended](https://gohugo.io/installation/)
- [Tea CLI](https://gitea.com/gitea/tea)
- [AWS CLI](https://aws.amazon.com/cli/)

### Community
- [Hugo Discourse](https://discourse.gohugo.io/)
- [Hugo GitHub](https://github.com/gohugoio/hugo)
- [Lynx Theme Issues](https://github.com/jpanther/lynx/issues)

---

**Next Steps**:
- Review [PROJECT_INDEX.md](PROJECT_INDEX.md) for complete documentation
- See [QUICK_REFERENCE.md](QUICK_REFERENCE.md) for quick commands
- Check [CLAUDE.md](../CLAUDE.md) for AI assistant guidelines

**Last Updated**: 2025-10-14
