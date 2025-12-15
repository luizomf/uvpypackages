# Agent Instructions

This repository is an educational monorepo. All code contained herein was
created for programming tutorials or lessons on Udemy and YouTube.

**Crucial:** Changes to the code must be kept to an absolute minimum to avoid
discrepancies between the recorded lessons and the current repository state.
Avoid making unnecessary changes to the logic or structure of the code.

---

## Directory Structure

The root directory serves as a container for different topics. For example, the
`namespaces` directory contains a complete project demonstrating Python's
Namespace Packages and `uv` Workspaces.

This structure must be preserved to accommodate future projects and tutorials.

---

## The `namespaces` Project

**Structure:**

```
$ cd namespaces
$ tree
.
└── titan-workspace
    ├── packages
    │   ├── package_a
    │   │   ├── pyproject.toml
    │   │   ├── README.md
    │   │   └── src
    │   │       └── titan
    │   │           └── mod_a.py
    │   ├── package_b
    │   │   ├── pyproject.toml
    │   │   ├── README.md
    │   │   └── src
    │   │       └── titan
    │   │           └── mod_b.py
    │   └── titan
    │       ├── pyproject.toml
    │       ├── README.md
    │       └── src
    │           └── titan
    │               └── mod_titan.py
    ├── pyproject.toml
    ├── README.md
    ├── stubs
    │   └── titan
    │       ├── mod_a.pyi
    │       ├── mod_b.pyi
    │       └── mod_titan.pyi
    └── uv.lock

14 directories, 16 files
```

**Key details:**

- All packages within `packages/` are individual projects with their own
  `README.md` and `pyproject.toml`.
- These packages are **built** separately.
- The workspace orchestrator is located in `namespaces/titan-workspace`.
- The workspace configuration file is
  `namespaces/titan-workspace/pyproject.toml`.

---

## Your Tasks

Your primary responsibility is documentation maintenance.

- Keep all `README.md` files and other documentation up to date with the code.
- Review files and apply necessary updates to descriptions, installation steps,
  or usage instructions.
- **Do not refactor code** unless explicitly requested, as preserving the
  educational state is the priority.

