# AIB Demo Setup - Session Summary
**Date:** February 16, 2026
**Session ID:** 3947cf28-fa3d-4c51-965e-6535f8dc3e86

## What We've Accomplished

### 1. Created New Organization
- **GitHub Org:** https://github.com/squidstack
- **Purpose:** AIB banking client RFP demo for CloudBees multi-component CI/CD orchestration

### 2. Cloned and Cleaned Repositories
Copied from `cb-squidstack` to `squidstack` with these 7 repos:
- ✅ **squidstack** - Central CloudBees workflows and orchestration
- ✅ **squid-ui** - React frontend with Feature Management
- ✅ **kraken-auth** - Authentication service
- ✅ **clam-catalog** - Product catalog service
- ✅ **codlocker-assets** - Static assets service (with Jenkinsfile + Unify workflow)
- ✅ **squidstack-terraform** - Infrastructure as Code
- ✅ **squidstack-e2e-tests** - End-to-end tests

Removed 8 stub services that weren't fully implemented.

### 3. Fixed Local Docker Compose Setup
- ✅ Merged database services into main docker-compose.yaml
- ✅ Added postgres, db-bootstrap, liquibase-auth, liquibase-catalog
- ✅ Fixed AUTH_DB_URL environment variables
- ✅ Fixed shell syntax errors in db-bootstrap
- ✅ Cleaned NGINX config to only proxy 3 services
- ✅ Updated services.js to show only 4 services
- ✅ Removed reef feeds component completely
- ✅ Fixed product catalog database schema (46 products loaded)
- ✅ Fixed asset serving (nginx location priority issue)

**Local Dev Status:** ✅ Fully working at http://localhost:3000

### 4. Updated All Workflow References
- ✅ Changed `cb-squidstack` → `squidstack` in all workflow files
- ✅ Changed `gururepservice` → `stacksdemo` for Docker registry
- ✅ Updated Jenkinsfile in codlocker-assets
- ✅ All changes committed and pushed to GitHub

### 5. CloudBees Integration Files
**Jenkinsfile (CloudBees CI):**
- Location: `codlocker-assets/Jenkinsfile`
- Uses Kaniko to build Docker images
- Registers artifacts with CloudBees Unify
- Pushes to `stacksdemo/codlocker-assets`

**Unify DSL Workflows:**
- Central reusable workflows in `squidstack/.cloudbees/workflows/`:
  - `test-generic.yaml` (with Smart Tests)
  - `build-generic.yaml`
  - `deploy-generic.yaml`
  - `release-generic.yaml`
- Component-specific workflows in each repo's `.cloudbees/workflows/`

### 6. All Repos Pushed to GitHub
All 7 repositories initialized, committed, and pushed:
- All workflows updated
- All Docker registry references updated
- No `cb-squidstack` references remain
- Ready for CloudBees Unify integration

---

## What Still Needs To Be Done

### 1. Create Docker Hub Account ⚠️ NEXT STEP
- Username: **stacksdemo**
- Generate access token
- Keep credentials for CloudBees Unify secrets

### 2. Configure CloudBees Unify Organization

**Variables (1):**
- `DOCKER_USER` = `stacksdemo`

**Secrets (8):**
- `DOCKER_TOKEN` = [stacksdemo Docker Hub token]
- `GITPAT` = [GitHub PAT with repo scope]
- `KUBECONFIG` = [Kubernetes cluster config]
- `JWT_SECRET` = [JWT signing secret]
- `KRAKEN_DB_PASSWORD` = [PostgreSQL password]
- `FM_KEY` = `b117ee65-1bfc-45ab-ab1e-37b652f834d1`
- `LAUNCHABLE_TOKEN` = [CloudBees Smart Tests token] (optional)
- `sb_internal_api` = [CloudBees Unify API token] (optional)

**Environments to Create:**
1. **squid-dev** (feature branches → dev)
2. **squid-preprod** (main → preprod)
3. **squid-prod** (main → preprod → prod)
4. **squid-demo-3** (release orchestration - optional)

### 3. Kubernetes Setup
Need namespaces in K8s cluster:
- `squid-dev`
- `squid-preprod`
- `squid-prod`

### 4. Environment Inventory Dashboard
**Critical for AIB Demo** - Customer loved this feature:
- Shows component versions across all environments
- Needs to be built/configured

### 5. Third-Party Integration Demos
For AIB demo requirements:
- ✅ CloudBees CI (Jenkinsfile in codlocker-assets)
- ⚠️ Checkmarx/Polaris (SCA tool integration)
- ⚠️ Jira approval integration
- ⚠️ Terraform with governance (Checkov, OPA, Infracost)

### 6. Component IDs for Release Orchestration
Already defined in workflows:
- squid-ui: `0459d9f1-4f37-4db1-bfb4-e2e1731a0975`
- kraken-auth: `2dc859d8-f3e1-44ca-9160-6e86a8077aab`
- clam-catalog: `f56d4494-5ff2-4497-961f-76a387ec724e`
- codlocker-assets: `097aaa38-4753-4471-97f4-e7265bd7bdc8`

---

## AIB Customer Requirements Recap

From the confidential RFP transcripts:

**What They Loved:**
- Environment inventory showing versions across environments
- Multi-component orchestration with different CI tools

**What They Need:**
- Mix of CloudBees CI + Unify DSL (not all Unify)
- Terraform with governance (Checkov, OPA, Infracost)
- Third-party integrations (Jira approvals, SCA tools)
- Show flexibility and power of the platform

**Key Differentiator:**
The environment inventory dashboard is what set CloudBees apart!

---

## Docker Image Registry

All images now push to **stacksdemo** account:
- `stacksdemo/squid-ui`
- `stacksdemo/kraken-auth`
- `stacksdemo/clam-catalog`
- `stacksdemo/codlocker-assets`
- `stacksdemo/squidstack-e2e-tests`

Completely separate from `gururepservice` used by cb-squidstack.

---

## Key Files and Locations

**Local Development:**
- Docker Compose: `/Users/brown/git_orgs/squidstack/squidstack/docker-compose.yaml`
- Running at: http://localhost:3000

**GitHub Repos:**
- All under: https://github.com/squidstack

**CloudBees Workflows:**
- Central: `squidstack/.cloudbees/workflows/`
- Components: Each repo has `.cloudbees/workflows/`

**Jenkinsfile:**
- `codlocker-assets/Jenkinsfile`
- `codlocker-assets/KubernetesPod.yaml`

**Feature Management:**
- FM Key: `b117ee65-1bfc-45ab-ab1e-37b652f834d1`
- Config: `squidstack/config/fm.json`

**Tasks Tracking:**
- `/Users/brown/git_orgs/squidstack/squidstack/TASKS.md`

---

## Session Backup Location

This conversation is automatically saved at:
```
/Users/brown/.claude/projects/-Users-brown--claude/3947cf28-fa3d-4c51-965e-6535f8dc3e86.jsonl
```

---

## Quick Start After Reboot

1. Check local dev still working: `cd /Users/brown/git_orgs/squidstack/squidstack && docker-compose ps`
2. Create stacksdemo Docker Hub account
3. Configure CloudBees Unify vars/secrets/environments
4. Test first workflow run
5. Build environment inventory dashboard

---

**Status:** Ready for CloudBees Unify configuration and demo build
