# Quick Reference Guide - The Angry Michigander

Fast reference for common operations and commands.

---

## 🚀 Quick Start

```bash
# Development
hugo server -D              # Start dev server with drafts
hugo server                 # Start without drafts (production preview)

# Production Build
hugo --minify              # Build optimized site
hugo                       # Build without minification

# Content Creation
hugo new posts/my-post.md  # Create new post
```

---

## 📁 Project Structure Map

```
angrymichigander/
├── archetypes/          # Content templates
│   └── default.md       # Default template
├── assets/              # Source assets (Hugo Pipes)
│   ├── css/
│   │   └── custom.css   # Custom CSS
│   ├── author.png       # Profile image
│   └── *.eps           # Vector graphics
├── content/            # Markdown content (create as needed)
│   └── posts/          # Blog posts
├── layouts/            # Layout overrides (create as needed)
├── static/             # Static files (create as needed)
├── public/             # Build output (gitignored)
├── .forgejo/
│   └── workflows/
│       └── deploy.yml  # CI/CD pipeline
├── hugo.yaml           # Main config
├── go.mod              # Go dependencies
└── docs/               # Project documentation
    ├── PROJECT_INDEX.md      # Full documentation
    └── QUICK_REFERENCE.md    # This file
```

---

## ⚙️ Configuration Files

| File | Purpose | Key Settings |
|------|---------|--------------|
| `hugo.yaml` | Main config | Theme, author, site settings |
| `go.mod` | Dependencies | Lynx theme v1.4.0 |
| `archetypes/default.md` | Content template | Date, draft, title |
| `assets/css/custom.css` | Custom styles | CSS overrides |

---

## 📝 Content Management

### Create New Content
```bash
hugo new posts/article-name.md
# Creates: content/posts/article-name.md
```

### Frontmatter Template
```yaml
---
date: '2025-10-14'
draft: false              # Change to false when ready
title: 'Article Title'
---
```

### Content Workflow
1. **Create**: `hugo new posts/name.md`
2. **Edit**: Modify content in `content/posts/name.md`
3. **Preview**: `hugo server -D`
4. **Publish**: Set `draft: false`
5. **Build**: `hugo --minify`
6. **Deploy**: Push to main (automatic via CI/CD)

---

## 🎨 Customization

### CSS Override
**File**: `assets/css/custom.css`
```css
/* Add custom styles */
.custom-class {
    /* Your styles */
}
```

### Layout Override
Create matching file structure in `layouts/`:
```
layouts/
├── _default/
│   ├── single.html
│   └── list.html
└── partials/
    └── header.html
```

### Theme Parameters
**File**: `hugo.yaml`
```yaml
params:
  author:
    name: Your Name
    headline: Your Headline
    # ... other params
```

---

## 🔧 Theme Management

### Lynx Theme (v1.4.0)

**Current Version**: v1.4.0
**Repository**: github.com/jpanther/lynx

### Update Theme
```bash
hugo mod get -u github.com/jpanther/lynx    # Update to latest
hugo mod get github.com/jpanther/lynx@v1.5.0  # Update to specific version
hugo mod tidy                               # Clean up dependencies
```

### Module Commands
```bash
hugo mod graph         # View dependency graph
hugo mod verify        # Verify dependencies
hugo mod vendor        # Vendor dependencies locally
hugo mod clean         # Clean module cache
```

---

## 🚢 Deployment

### Automatic Deployment (Forgejo Actions)

**Trigger**: Push to `main` branch
**Runner**: Self-hosted
**Target**: AWS S3

**Pipeline Steps**:
1. Checkout code
2. Setup Hugo extended
3. Build with `hugo --minify`
4. Configure AWS credentials
5. Sync to S3 with `--delete`

### Manual Deployment
```bash
# Build
hugo --minify

# Deploy to S3 (manual)
aws s3 sync public/ s3://YOUR-BUCKET-NAME --delete
```

### Required Secrets (Forgejo)
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `S3_BUCKET_NAME`

---

## 🔍 Version Control

### Forgejo Operations (Tea CLI)

```bash
# Pull Requests
tea pulls list                    # List all PRs
tea pulls create                  # Create new PR
tea pulls [index]                 # View PR details
tea pulls merge [index]           # Merge PR

# Issues
tea issues list                   # List all issues
tea issues create                 # Create new issue
tea issues [index]                # View issue details
tea issues close [index]          # Close issue

# Repository
tea repos                         # List repositories
tea releases                      # List releases
```

### Git Workflow
```bash
# Standard workflow
git checkout -b feature/new-post
# ... make changes ...
git add .
git commit -m "Add new post"
git push origin feature/new-post
tea pulls create                  # Create PR via tea
```

---

## 🐛 Troubleshooting

### Common Issues

#### Module Errors
```bash
hugo mod tidy           # Fix module issues
hugo mod clean          # Clear module cache
hugo mod get -u         # Update all modules
```

#### Build Failures
```bash
# Check Hugo version
hugo version

# Should be: Hugo Extended v0.1xx.x or later
# Install from: https://gohugo.io/installation/
```

#### Theme Not Loading
```bash
# Verify module import
grep -A 2 "module:" hugo.yaml

# Should show:
# module:
#   imports:
#     - path: github.com/jpanther/lynx
```

#### Deployment Failures
1. Check AWS credentials in Forgejo secrets
2. Verify S3 bucket name
3. Check IAM permissions for S3 sync
4. Review workflow logs in Forgejo

---

## 📊 Site Structure

### Hugo Directory Functions

| Directory | Function | Processed | Output |
|-----------|----------|-----------|--------|
| `content/` | Markdown files | ✅ | HTML pages |
| `layouts/` | Templates | ✅ | Part of pages |
| `static/` | Static files | ❌ | Copied as-is |
| `assets/` | Source assets | ✅ | Optimized assets |
| `archetypes/` | Templates | ❌ | Used by `hugo new` |
| `data/` | Data files | ✅ | Available in templates |
| `public/` | Build output | ❌ | Deployed site |

### Build Process Flow
```
Markdown (content/) + Templates (layouts/) + Config (hugo.yaml)
    ↓
Hugo Build Process
    ↓
Static HTML/CSS/JS (public/)
    ↓
Deploy to S3
```

---

## 💡 Tips & Best Practices

### Content
- Use descriptive filenames (kebab-case)
- Always set proper frontmatter
- Preview with `hugo server -D` before publishing
- Use `draft: true` for work-in-progress

### Development
- Keep Hugo extended updated
- Run `hugo mod tidy` after dependency changes
- Test builds locally before pushing
- Use feature branches for significant changes

### Performance
- Always build with `--minify` for production
- Optimize images before adding to `assets/`
- Use Hugo's image processing for responsive images
- Leverage CDN (CloudFront assumed)

### Security
- Never commit `public/` directory
- Keep AWS credentials in Forgejo secrets only
- Review workflow permissions regularly
- Use IAM least-privilege for S3 access

---

## 📚 Documentation Links

### Internal
- [Complete Project Documentation](PROJECT_INDEX.md)
- [CLAUDE.md](../CLAUDE.md) - AI assistant guidelines
- [README.md](../README.md) - Project overview

### External
- [Hugo Documentation](https://gohugo.io/documentation/)
- [Lynx Theme Guide](https://github.com/jpanther/lynx)
- [Hugo Modules](https://gohugo.io/hugo-modules/)
- [Forgejo Docs](https://forgejo.org/docs/)
- [Tea CLI](https://gitea.com/gitea/tea)

---

## 🔑 Key File Locations

```bash
# Configuration
hugo.yaml:4-34          # Site config and theme params
go.mod:1-6              # Module dependencies

# Templates
archetypes/default.md:1-6   # Content template

# Styling
assets/css/custom.css:1-2   # Custom CSS overrides

# CI/CD
.forgejo/workflows/deploy.yml:1-37  # Deployment workflow

# Documentation
docs/PROJECT_INDEX.md       # Complete documentation
docs/QUICK_REFERENCE.md     # This guide
```

---

**Quick Help**:
- For detailed information → [PROJECT_INDEX.md](PROJECT_INDEX.md)
- For Hugo help → `hugo help [command]`
- For tea help → `tea help [command]`
- For theme help → https://github.com/jpanther/lynx

**Last Updated**: 2025-10-14
