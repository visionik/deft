# Semantic Versioning Standards

Legend (from RFC2119): !=MUST, ~=SHOULD, ≉=SHOULD NOT, ⊗=MUST NOT, ?=MAY.

**⚠️ See also**: [main.md](../main.md) | [git.md](../tools/git.md) | [github.md](../tools/github.md)

**Specification**: [Semantic Versioning 2.0.0](https://semver.org/spec/v2.0.0.html)

## Summary

Given a version number **MAJOR.MINOR.PATCH**, increment the:

- **MAJOR** version when you make incompatible changes that break user expectations or existing integrations
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

**Applies to**: Libraries, APIs, web applications, CLI tools, mobile apps, documentation systems, frameworks, and any versioned software or content.

## Version Format

**Standard version**: `MAJOR.MINOR.PATCH` (e.g., `1.4.2`)

**Pre-release version**: `MAJOR.MINOR.PATCH-prerelease` (e.g., `1.0.0-alpha.1`)

**Build metadata**: `MAJOR.MINOR.PATCH+build` (e.g., `1.0.0+20130313144700`)

**Combined**: `MAJOR.MINOR.PATCH-prerelease+build` (e.g., `1.0.0-beta.2+exp.sha.5114f85`)

## Core Rules

### Version Numbers

- ! Version numbers **MUST** take the form `X.Y.Z` where X, Y, and Z are non-negative integers
- ! Version numbers **MUST NOT** contain leading zeroes (e.g., `1.01.0` is invalid)
- ! Each element **MUST** increase numerically (e.g., `1.9.0` → `1.10.0` → `1.11.0`)

### Public Interface

- ! Software using Semantic Versioning **MUST** declare a public interface
- ~ Interface **SHOULD** be documented clearly (API docs, user guide, UI behavior, CLI commands)
- ~ Interface **SHOULD** be precise and comprehensive

**Public interface includes**:
- APIs (REST, GraphQL, library functions)
- User interfaces (web UI, mobile UI, desktop UI)
- Command-line interfaces (CLI commands, flags, output format)
- Configuration formats (config files, environment variables)
- Data formats (database schemas, file formats, message formats)
- Behavior expectations (UI workflows, response formats, error handling)

### Version 0.y.z (Initial Development)

- ? **MAY** use version `0.y.z` for initial development
- ! Version `0.y.z` indicates unstable interface that **MAY** change at any time
- ! Public interface **SHOULD NOT** be considered stable until version `1.0.0`

### Version 1.0.0 and Beyond

- ! Version `1.0.0` defines the stable public interface
- ! After `1.0.0`, version increments depend on how the public interface changes

### PATCH Version (Z in X.Y.Z)

- ! **MUST** increment when only backward compatible bug fixes are introduced
- ! Bug fix = internal change that fixes incorrect behavior

### MINOR Version (Y in X.Y.Z)

- ! **MUST** increment when new backward compatible functionality is added to the public interface
- ! **MUST** increment if any public interface functionality is marked as deprecated
- ? **MAY** increment if substantial new functionality or improvements are introduced internally
- ! **MUST** reset PATCH version to 0 when MINOR increments (e.g., `1.3.7` → `1.4.0`)

### MAJOR Version (X in X.Y.Z)

- ! **MUST** increment when any backward incompatible changes are introduced to the public interface
- ? **MAY** include MINOR and PATCH level changes
- ! **MUST** reset MINOR and PATCH to 0 when MAJOR increments (e.g., `2.4.7` → `3.0.0`)

**Breaking changes include**:
- Removed or renamed APIs, functions, CLI commands, or UI features
- Changed behavior that breaks user expectations or workflows
- Modified data formats that require migration
- Altered UI layouts that significantly change user experience
- Changed configuration formats requiring updates
- Removed or changed error codes, status codes, or messages that clients depend on

### Pre-release Versions

- ! Pre-release version **MUST** be denoted by appending a hyphen and series of dot-separated identifiers (e.g., `1.0.0-alpha`, `1.0.0-alpha.1`)
- ! Identifiers **MUST** comprise only ASCII alphanumerics and hyphens `[0-9A-Za-z-]`
- ! Identifiers **MUST NOT** be empty
- ! Numeric identifiers **MUST NOT** include leading zeroes
- ! Pre-release versions have lower precedence than the normal version (e.g., `1.0.0-alpha < 1.0.0`)

### Build Metadata

- ! Build metadata **MUST** be denoted by appending a plus sign and series of dot-separated identifiers (e.g., `1.0.0+20130313144700`)
- ! Identifiers **MUST** comprise only ASCII alphanumerics and hyphens `[0-9A-Za-z-]`
- ! Build metadata **SHOULD** be ignored when determining version precedence
- ! Two versions that differ only in build metadata have the same precedence (e.g., `1.0.0+build1 == 1.0.0+build2`)

### Version Immutability

- ! Once a versioned package has been released, the contents **MUST NOT** be modified
- ! Any modifications **MUST** be released as a new version

## Precedence Rules

Precedence determines how versions are compared:

1. ! Precedence **MUST** be calculated by separating into MAJOR, MINOR, PATCH, and pre-release identifiers
2. ! MAJOR, MINOR, and PATCH are compared numerically (e.g., `1.0.0 < 2.0.0 < 2.1.0 < 2.1.1`)
3. ! Pre-release versions have **lower** precedence than normal versions (e.g., `1.0.0-alpha < 1.0.0`)
4. ! Pre-release identifiers are compared from left to right:
   - Numeric identifiers compared as integers
   - Alphanumeric identifiers compared lexically in ASCII sort order
   - Numeric identifiers always have lower precedence than non-numeric
   - Larger set of pre-release fields has higher precedence than smaller set (if all preceding identifiers are equal)

**Precedence examples** (lowest to highest):

```
1.0.0-alpha
1.0.0-alpha.1
1.0.0-alpha.beta
1.0.0-beta
1.0.0-beta.2
1.0.0-beta.11
1.0.0-rc.1
1.0.0
```

## Common Pre-release Labels

~ Commonly used pre-release identifiers:

- **alpha** (`1.0.0-alpha.1`) - Early testing, unstable, incomplete features
- **beta** (`1.0.0-beta.1`) - Feature complete, testing for bugs
- **rc** (`1.0.0-rc.1`) - Release candidate, potentially final unless issues found

## Examples

### Bug Fix (PATCH)

**API/Library:**
```
Current: 1.4.2
Change: Fixed off-by-one error in date parsing
New version: 1.4.3
```

**Web UI:**
```
Current: 2.1.5
Change: Fixed broken pagination on search results
New version: 2.1.6
```

**CLI Tool:**
```
Current: 0.8.3
Change: Fixed crash when input file is empty
New version: 0.8.4
```

### New Feature (MINOR)

**API/Library:**
```
Current: 1.4.3
Change: Added search() function to API
New version: 1.5.0
```

**Web UI:**
```
Current: 2.1.6
Change: Added dark mode support
New version: 2.2.0
```

**CLI Tool:**
```
Current: 0.8.4
Change: Added --format json option
New version: 0.9.0
```

### Breaking Change (MAJOR)

**API/Library:**
```
Current: 1.5.0
Change: Removed deprecated getUser() function
New version: 2.0.0
```

**Web UI:**
```
Current: 2.2.0
Change: Redesigned navigation, moved settings from top bar to sidebar
New version: 3.0.0
```

**CLI Tool:**
```
Current: 0.9.0
Change: Changed --output flag to --file, removed --verbose (use --log-level instead)
New version: 1.0.0
```

### Pre-release

```
Current: 2.0.0
Change: Alpha testing for 2.1.0
New version: 2.1.0-alpha.1
```

### Release Cycle

```
1.0.0           # Initial release
1.0.1           # Bug fix
1.1.0-alpha.1   # Alpha testing new features
1.1.0-beta.1    # Beta testing
1.1.0-rc.1      # Release candidate
1.1.0           # Stable release
2.0.0-alpha.1   # Alpha for breaking changes
2.0.0           # Major release with breaking changes
```

## Integration with Git & GitHub

### Git Tags

```bash
# Tag a release (! MUST use v prefix)
git tag -a v1.4.2 -m "Release v1.4.2"
git push origin v1.4.2

# Pre-release
git tag -a v2.0.0-beta.1 -m "Beta release for v2.0.0"
git push origin v2.0.0-beta.1
```

### GitHub Releases

```bash
# Create release with semantic version
gh release create v1.4.2 --title "v1.4.2" --notes-file CHANGELOG.md

# Pre-release
gh release create v2.0.0-beta.1 --title "v2.0.0-beta.1" --notes-file CHANGELOG.md --prerelease
```

## Decision Tree

**What changed?**

1. **Fixed a bug without changing behavior?**
   - Yes: Increment PATCH → `X.Y.Z+1`

2. **Added new feature without breaking existing functionality?**
   - Yes: Increment MINOR → `X.Y+1.0`

3. **Made breaking changes that affect users or integrations?**
   - Yes: Increment MAJOR → `X+1.0.0`
   - Examples: Removed features, changed UI workflows, renamed commands, modified data formats

4. **Testing new version?**
   - Alpha: `X.Y.Z-alpha.N`
   - Beta: `X.Y.Z-beta.N`
   - RC: `X.Y.Z-rc.N`

5. **Just metadata (build info)?**
   - Append with `+`: `X.Y.Z+metadata`

## FAQ

**Q: How do I know when to release 1.0.0?**
A: When your software is stable and being used by others who depend on consistent behavior. Once you release 1.0.0, you're committing to semantic versioning discipline.

**Q: Does SemVer mean I can't make breaking changes?**
A: No, but you must increment the MAJOR version and communicate clearly in your changelog.

**Q: What if I accidentally release a breaking change as a MINOR version?**
A: Release a new MINOR version that restores compatibility, then release a new MAJOR version with the breaking change properly documented.

**Q: What about deprecations?**
A: Deprecate in a MINOR version (with warnings/docs), remove in the next MAJOR version. Give users time to adapt.

**Q: Should I use v prefix for tags?**
~ Yes, it's conventional (e.g., `v1.0.0` instead of `1.0.0`)

**Q: What about 0.y.z versions?**
A: Use during initial development. Anything goes. Interface not stable until 1.0.0.

**Q: Is a UI redesign a breaking change?**
A: It depends. If it significantly changes user workflows or removes features users depend on, yes. If it's a visual refresh that preserves functionality, no (MINOR).

**Q: Are database schema changes breaking?**
A: If they require migration or break existing queries/integrations, yes (MAJOR). If backward compatible (adding optional columns), no (MINOR).

## Compliance

- ! **MUST** use format `MAJOR.MINOR.PATCH` (e.g., `1.4.2`)
- ! **MUST** increment MAJOR for breaking changes to public interface
- ! **MUST** increment MINOR for new backward compatible features
- ! **MUST** increment PATCH for backward compatible bug fixes
- ~ **SHOULD** use pre-release versions for testing (`-alpha`, `-beta`, `-rc`)
- ! **MUST NOT** modify released versions
- ! **MUST** declare and document public interface (API, UI, CLI, config formats, data formats)
- ~ **SHOULD** use `v` prefix for git tags (e.g., `v1.0.0`)
- ~ **SHOULD** document breaking changes in CHANGELOG.md with migration guides

---

**See also**:
- [Semantic Versioning 2.0.0](https://semver.org/spec/v2.0.0.html) - Full specification
- [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) - CHANGELOG format
- [tools/git.md](../tools/git.md) - Git tagging and workflow
- [tools/github.md](../tools/github.md) - GitHub releases
