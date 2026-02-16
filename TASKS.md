# SquidStack AIB Demo - Tasks

**Project:** SquidStack for AIB RFP Demo
**Created:** 2026-02-16
**Status:** In Progress

---

## Task Status

| # | Task | Owner | Status | Priority |
|---|------|-------|--------|----------|
| 1 | Copy 7 components from cb-squidstack to squidstack | Claude | ✅ Done | High |
| 2 | Remove reef feeds references from squid-ui | - | 📋 Pending | High |
| 3 | Create README.md and TASKS.md | Claude | 🔄 In Progress | High |
| 4 | Initialize git repos for all 7 components | - | 📋 Pending | High |
| 5 | Push all repos to squidstack GitHub org | - | 📋 Pending | High |
| 6 | Update workflow references (cb-squidstack → squidstack) | - | 📋 Pending | High |
| 7 | Add Checkmarx/Polaris integration | - | 📋 Pending | Medium |
| 8 | Add Jira approval integration | - | 📋 Pending | Medium |
| 9 | Create environment inventory dashboard | - | 📋 Pending | High |
| 10 | Add one CloudBees CI pipeline (show mix) | - | 📋 Pending | Low |
| 11 | Update documentation for AIB context | - | 📋 Pending | Medium |
| 12 | Test end-to-end demo flow | - | 📋 Pending | High |

**Legend:**
- ✅ Done
- 🔄 In Progress
- 📋 Pending
- ❌ Blocked

---

## Detailed Task Breakdown

### ✅ Task 1: Copy Components (COMPLETED)

**What was copied:**
- squid-ui/
- kraken-auth/
- clam-catalog/
- codlocker-assets/
- squidstack-terraform/
- squidstack-e2e-tests/
- cb-squidstack/ → squidstack/

**Exclusions applied:**
- .git/ directories
- node_modules/
- Build artifacts (binaries, coverage.out, *.tar.gz, *.zip)
- .DS_Store files
- venv/ directories

**What was NOT copied:**
- reef-* components (feeds feature)
- Stub services (barnacle-reviews, cuttlefish-orders, etc.)
- Utility directories (app_config, flags, utils, tests, scripts, working)

---

### 📋 Task 2: Remove Reef Feeds from squid-ui

**Files to modify:**
- `src/api/reef.js` - Remove API client
- `src/components/ReefFeedPanel.jsx` - Remove component
- `src/styles/ReefFeedPanel.css` - Remove styles
- `nginx.conf` / `nginx.docker.conf` - Remove reef proxy routes
- Any UI components that reference feeds

**Testing:**
- Verify UI builds without errors
- Check no broken imports
- Test that auth and catalog still work

---

### 📋 Task 4-5: Git Initialization & GitHub Push

**For each component:**
1. `cd <component-dir>`
2. `git init`
3. `git add .`
4. `git commit -m "Initial commit from cb-squidstack"`
5. `git remote add origin git@github.com:squidstack/<component-name>.git`
6. `git push -u origin main`

**Repositories to create:**
1. squidstack/squid-ui
2. squidstack/kraken-auth
3. squidstack/clam-catalog
4. squidstack/codlocker-assets
5. squidstack/squidstack-terraform
6. squidstack/squidstack-e2e-tests
7. squidstack/squidstack (central workflows)

---

### 📋 Task 6: Update Workflow References

**Files to update:**
All `.cloudbees/workflows/*.yaml` files in each component

**Change:**
```yaml
# Before:
uses: github.com/cb-squidstack/cb-squidstack/.cloudbees/workflows/deploy-generic.yaml@main

# After:
uses: github.com/squidstack/squidstack/.cloudbees/workflows/deploy-generic.yaml@main
```

---

### 📋 Task 7: Checkmarx/Polaris Integration

**Requirement:** AIB is buying Checkmarx or Polaris for SCA

**Implementation:**
- Add Checkmarx/Polaris scan step to workflows
- Integrate scan results into CloudBees Unify dashboard
- Show vulnerabilities found across components
- Demo blocking deployment on HIGH/CRITICAL findings

**Estimated effort:** 2-3 hours

---

### 📋 Task 8: Jira Approval Integration

**Requirement:** Manual approvals with ticketing integration

**Implementation:**
- Add Jira ticket creation on PROD deployment trigger
- Show approval gate waiting for Jira ticket status
- Demo manual approval → deployment proceeds
- Alternative: Mock the flow if no Jira instance available

**Estimated effort:** 1-2 hours

---

### 📋 Task 9: Environment Inventory Dashboard

**Requirement:** "They LOVED this feature" - version tracking across environments

**Implementation:**
- Build visualization showing versions per component per environment:
  ```
  Component       | DEV     | PREPROD | PROD
  ----------------|---------|---------|--------
  squid-ui        | v0.1.5  | v0.1.4  | v0.1.3
  kraken-auth     | v0.1.2  | v0.1.1  | v0.1.0
  clam-catalog    | v0.1.3  | v0.1.2  | v0.1.1
  ```
- Show visual diff of what would be promoted
- Use CloudBees Unify API to fetch deployment data
- Create dashboard (web page or CLI tool)

**Estimated effort:** 4-6 hours

---

### 📋 Task 10: Add CloudBees CI Pipeline

**Requirement:** Show mix of CloudBees CI and Unify DSL

**Implementation:**
- Pick one component (maybe codlocker-assets - simplest)
- Create traditional CloudBees CI Jenkinsfile
- Show orchestration from Unify calling both CI types
- Document the flexibility

**Estimated effort:** 2-3 hours

---

### 📋 Task 11: Update Documentation

**Files to update:**
- All component README.md files (update GitHub links)
- Main squidstack/README.md (focus on AIB requirements)
- Add AIB-specific use cases and scenarios

**Estimated effort:** 1-2 hours

---

### 📋 Task 12: End-to-End Demo Test

**Test scenarios:**
1. Trigger multi-component build
2. Show environment inventory
3. Promote to PREPROD
4. Show Terraform governance (Checkov blocks bad config)
5. Show Checkmarx finding vulnerabilities
6. Manual approval for PROD
7. Deploy to PROD
8. Show unified dashboard

**Estimated effort:** 2-3 hours

---

## Total Estimated Effort

| Priority | Hours |
|----------|-------|
| High     | 15-20 |
| Medium   | 4-6   |
| Low      | 2-3   |
| **Total**| **21-29 hours** |

---

## Notes

- **Completed 2026-02-16:** Copied 7 components, cleaned up structure
- **Next Priority:** Initialize git repos and push to GitHub
- **Blockers:** Need squidstack GitHub org access, CloudBees Unify org decision

---

## Questions / Decisions Needed

1. ✅ Which components to copy? → Decided: 7 core components only
2. ✅ Include reef feeds? → Decided: No, remove from squid-ui
3. ❓ Which CloudBees Unify org to use? → TBD (need external user access)
4. ❓ When is AIB demo scheduled? → TBD
5. ❓ Who is assigned to each task? → TBD
6. ❓ Do we have Checkmarx/Polaris instance for integration? → TBD
7. ❓ Do we have Jira instance for approval demo? → TBD
