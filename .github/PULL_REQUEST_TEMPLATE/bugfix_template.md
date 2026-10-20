<!-- ⚠️ DELETE THIS ENTIRE SECTION BEFORE SUBMITTING THE PR ⚠️ -->

# Bugfix PR Template
## Usage Instructions 
### Checklist for Usage Instructions & Submission:
Before submitting this PR, please ensure:
1. [ ] **Add Reviewers**: At least **2 reviewers** have been added to this PR using the Reviewers panel.  
2. [ ] **Commit Squashing**: Ensure commits have been **squashed** before merging (or commits will be squashed during the merge process).  
3. **Verify that**: 
    - [ ] Code passes linting checks (use `black`, `flake8`) with no error.  
    - [ ] Tests have been added for new features or bug fixes.  
    - [ ] Documentation (README, notebooks, etc.) is updated if applicable. 
4. [ ] **Delete the Usage Instructions section** before submitting.

---
<!-- ⚠️ DELETE THIS ENTIRE SECTION BEFORE SUBMITTING THE PR ⚠️ -->
<!-- BUGFIX_TEMPLATE_v1 — do not delete this line; .github/workflows/template-enforcer.yml checks for it -->


## Bugfix Summary
<!-- Summarize the bug fixed. Example: 
- Fixes incorrect handling of timezones during datetime parsing.
-->


## Steps to Reproduce
<!-- Provide steps to reproduce the bug. Example:
1. Pass a timestamp in any timezone.
2. Run the `datetime_parser.py` script. 
-->
1.  
2.  
3.  

## Fix Implementation
<!-- Details on the resolution. Example:
- Switched parser from `strptime()` to `dateutil.parser`.
-->


## Checklist
<!-- Provide checklist to ensure bugfix quality. Example:
- [ ] Bugfix verified with multiple timezones.
- [ ] Updated failing tests in `test_datetime_parser.py`. 
-->
