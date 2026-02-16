# SquidStack AIB Demo - Discussion Log

**Project:** SquidStack for AIB RFP Demo
**Created:** 2026-02-16

---

## 2026-02-16: Initial Setup & Planning

### Context

AIB (banking client) has issued an RFP for CloudBees CI/CD solutions. We need to create a comprehensive demo showing:
- Multi-component CI/CD orchestration
- CloudBees Unify as platform orchestrator
- Mix of CloudBees CI and Unify DSL pipelines
- Infrastructure as Code with governance
- Environment inventory (they specifically loved this feature)
- Third-party integrations (Checkmarx/Polaris, Jira)

### Transcripts Summary

From customer conversations, key requirements:

**Core Requirements:**
1. Multi-component pipeline (database, frontend, backend)
2. Orchestrator on top using Unify
3. Show flexibility - mix of CloudBees CI + Unify DSL
4. **Environment inventory** ⭐ - "really, really cool" - version tracking across DEV/TEST/PRE/PROD
5. Infrastructure as Code (optional but valued) - Terraform with Checkov, OPA, Sentinel-style policies, Infracost
6. Integration with Checkmarx/Polaris (they're buying SCA tool separately)
7. Centrally managed workflows (not committed in project repos)
8. Promotion workflows with manual approval gates
9. Integration with ticketing (Jira/Remedy)
10. Unified dashboard showing all components, security across environments

**Customer Quote:**
> "We remember in the demo that you show us an environment mapping that was **really, really cool** and would allow us to give you a look of an understanding of the versions across different environments"

### Decisions Made

#### 1. Use SquidStack as Base Application ✅

**Why?**
- Multi-component architecture (frontend, backend, database)
- Already has CloudBees Unify orchestration
- Has Terraform with governance (Checkov, OPA, Infracost)
- Has multi-environment setup (dev, preprod, prod)
- Fully working application, not just stubs

**Concerns raised:**
- Is "fish wholesaler" theme appropriate for banking client?
- Decision: Theme doesn't matter - focus is on CI/CD patterns

**Alternative considered:**
- AccountStack - but currently mono repo, wouldn't show multi-component orchestration as well

#### 2. Clean Up - Remove Unused Components ✅

**Removed from scope:**
- Reef feeds (reef-feed-aggregator, reef-asia, reef-eu, reef-na, reef-sa) - Not needed for demo
- Stub services (barnacle-reviews, cuttlefish-orders, octopus-payments, etc.) - No business logic
- Utility directories (app_config, flags, utils, tests, scripts, working)

**Kept (7 components):**
1. squid-ui - React frontend + NGINX API Gateway
2. kraken-auth - Authentication & User Management
3. clam-catalog - Product Catalog & Stock
4. codlocker-assets - Static Asset Server
5. squidstack-terraform - IaC with governance
6. squidstack-e2e-tests - End-to-end tests
7. squidstack - Central workflow templates

#### 3. Copy Strategy ✅

**Option B Selected:** Selective copy
- Copy all source code, configs, workflows
- Exclude: .git/, node_modules/, build artifacts, .DS_Store

**Rationale:** Fresh start for new organization, cleaner repos

#### 4. New GitHub Organization ✅

**Created:** `squidstack` organization (separate from cb-squidstack)
**Repository:** `/Users/brown/git_orgs/squidstack/squidstack` initialized locally

**Reason:** Clean separation for AIB demo, avoid confusion with development version

### TODO: Remove Reef Feeds from squid-ui

Since we're not including the reef-* components, need to:
- Remove reef API client (`src/api/reef.js`)
- Remove reef UI components (`src/components/ReefFeedPanel.jsx`)
- Remove reef styles (`src/styles/ReefFeedPanel.css`)
- Update NGINX config (remove reef proxy routes)
- Verify no broken references

### Questions Raised

#### 1. Do Francois or Sylvain already have something in progress?
**Status:** Asked in meeting
**Answer:** TBD

#### 2. Which CloudBees Unify org to use?
**Problem:** CloudBees org is unstable + can't add external users (breaks approval workflow demos)
**Status:** Needs decision
**Impact:** Critical for demo - need different users for approval gates

#### 3. When is AIB demo scheduled?
**Status:** Unknown
**Impact:** Determines timeline urgency

#### 4. Task assignments?
**Status:** TBD
**Need:** Spreadsheet with owners and timelines

#### 5. Do we have Checkmarx/Polaris instance?
**Status:** TBD
**Impact:** Can we show real integration or need to mock?

#### 6. Do we have Jira instance for approval demo?
**Status:** TBD
**Alternative:** Mock the approval flow

### Work Completed Today

✅ Analyzed cb-squidstack components (identified 7 to keep, 18 to remove)
✅ Copied 7 components to new squidstack directory with selective exclusions
✅ Created TASKS.md for task tracking
✅ Created DISCUSSION.md for conversation log
🔄 Creating README.md focused on AIB requirements

### Next Steps

1. Update squidstack/README.md for AIB focus
2. Initialize git repos for all 7 components
3. Create repos in squidstack GitHub org
4. Push all components to GitHub
5. Remove reef feeds from squid-ui
6. Update workflow references (cb-squidstack → squidstack)

---

## Notes for Team

- **Environment inventory is the killer feature** - AIB specifically called this out as impressive
- They're buying Checkmarx or Black Duck for SCA - focus on integration, not built-in scanning
- They want to see governance (policies, cost control, security scanning) - squidstack-terraform perfect for this
- Manual approvals with Jira integration important to show
- Centralized workflows (already have this) solves their pain point

---

## Meeting Notes

### Internal Meeting - 2026-02-16

**Attendees:** TBD
**Topics:**
- Review AIB requirements
- Confirm squidstack as base application
- Decide on CloudBees Unify org
- Assign tasks and timelines

**Decisions:** TBD

---

## AIB Demo Requirements Checklist

From transcripts, tracking what we have vs need:

| Requirement | Have? | Notes |
|-------------|-------|-------|
| Multi-component CI/CD | ✅ | 4 services + infrastructure |
| Unify as orchestrator | ✅ | Already implemented |
| Mix CI + Unify DSL | ⚠️ | Have Unify DSL, need to add CI pipeline |
| Environment inventory | ⚠️ | Capability exists, need dashboard viz |
| Terraform with governance | ✅ | Checkov, OPA, Infracost all there |
| Checkmarx/Polaris integration | ❌ | Need to add |
| Jira approval integration | ❌ | Need to add |
| Centralized workflows | ✅ | Already have |
| Promotion workflows | ✅ | Branch-based promotion working |
| Unified dashboard | ⚠️ | Unify has dashboard, may need customization |
| SBOM generation | ⚠️ | Can add easily |
| Visual dependencies | ⚠️ | Have in Unify, may need to highlight |

---

## Resources

**Transcripts:**
- Customer transcript 1: CI requirements, multi-component orchestration
- Customer transcript 2: Infrastructure, optional features, demo organization
- Customer transcript 3: Clarifications, mixed lot requirements
- Gabs (AE lead): Final instructions and context

**Repositories:**
- Original: `/Users/brown/git_orgs/cb-squidstack/`
- New: `/Users/brown/git_orgs/squidstack/`
- GitHub: `https://github.com/squidstack`

**Documentation:**
- TASKS.md - Task tracking
- README.md - Project overview
- This file - Discussion log
