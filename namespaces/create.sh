#!/usr/bin/env bash

set -o errexit

CURDIR=$(cd "$(dirname "$0")" && pwd)

PROJECT_DIR_NAME="titan"
PROJECT_VERSION="0.0.1"
PACKAGES_DIR_NAME="packages"

AUTHOR_NAME="Luiz Otávio Miranda"
PYTHON_VERSION="3.14.2"

PROJECT_DIR=$CURDIR/$PROJECT_DIR_NAME
PACKAGES_DIR=$PROJECT_DIR/$PACKAGES_DIR_NAME

MAIN_PYTOML_PATH=$PROJECT_DIR/pyproject.toml
MAIN_README_PATH=$PROJECT_DIR/README.md

PACKAGES_PREFIX="package_"

PACKAGE_A_NAME="${PACKAGES_PREFIX}a"
PACKAGE_B_NAME="${PACKAGES_PREFIX}b"

PACKAGE_A_DIR=$PACKAGES_DIR/$PACKAGE_A_NAME
PACKAGE_B_DIR=$PACKAGES_DIR/$PACKAGE_B_NAME

PACKAGE_A_SRCDIR="${PACKAGE_A_DIR}/src/${PROJECT_DIR_NAME}"
PACKAGE_B_SRCDIR="${PACKAGE_B_DIR}/src/${PROJECT_DIR_NAME}"

PYTHON_VERSION_NUMBER=$(echo $PYTHON_VERSION | tr -dc '[0-9.]')

create_readme() {
cat << EOF > $1
# Hello from $2

Please, if you are creating this project, take the time to write me.

---
EOF
}

create_package_pytoml() {
cat << EOF > $1
[project]
name = "$2"
version = "0.0.1"

[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[tool.hatch.build.targets.wheel]
packages = ["./src/$3"]

[tool.ruff]
extend = '../../pyproject.toml'

[tool.pyright]
extends = '../../pyproject.toml'
EOF
}

create_sample_fn() {
cat << EOF > $1
def $2() -> None:
    print("Hello from $3")


if __name__ == "__main__":
    $2()
EOF
}

mkdir -p $PACKAGES_DIR $PACKAGE_A_SRCDIR $PACKAGE_B_SRCDIR

create_readme $MAIN_README_PATH $PROJECT_DIR_NAME

create_readme "${PACKAGE_A_DIR}/README.md" $PACKAGE_A_NAME
create_readme "${PACKAGE_B_DIR}/README.md" $PACKAGE_B_NAME

create_package_pytoml "${PACKAGE_A_DIR}/pyproject.toml" $PACKAGE_A_NAME $PROJECT_DIR_NAME
create_package_pytoml "${PACKAGE_B_DIR}/pyproject.toml" $PACKAGE_B_NAME $PROJECT_DIR_NAME

create_sample_fn "${PACKAGE_A_SRCDIR}/mod_a.py" 'func_a' $PACKAGE_A_NAME
create_sample_fn "${PACKAGE_A_SRCDIR}/mod_b.py" 'func_b' $PACKAGE_B_NAME

cat << EOF > $MAIN_PYTOML_PATH
[project]
name = "$PROJECT_DIR_NAME-workspace"
version = "$PROJECT_VERSION"
description = "The author didn't write a description yet."
requires-python = "<=$PYTHON_VERSION"
readme = "README.md"
license = "MIT"
authors = [{ name = "$AUTHOR_NAME" }]
dependencies = []

[tool.uv]
managed = true # The project is managed by uv
package = false # But it is not a package.

[tool.uv.workspace]
members = ["$PACKAGES_DIR_NAME/*"]

[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[tool.uv.sources]
$PROJECT_DIR_NAME = { workspace = true }
$PACKAGE_A_NAME = { workspace = true }
$PACKAGE_B_NAME = { workspace = true }

# ALL COMMENTED LINES ARE FOR REFERENCE (COPY AND PASTE WHERE NEEDED)

# [tool.hatch.build.targets.wheel]
# packages = [] # We are the workspace and have no packages.
# include = [] # If you have files to be includes, use this

# [project.scripts]
# dockerlabs = "dockerlabs.cli:main"

# [tool.ruff]
# line-length = 88
# target-version = "py$(echo $PYTHON_VERSION_NUMBER | tr -dc '[0-9]' | cut -c 1-3)"
# fix = true
# show-fixes = true
# indent-width = 4
# exclude = ["venv", ".venv", "env", ".env", "node_modules", "__pycache__"]
 
# [tool.ruff.lint]
# select = ["ALL"]
# ignore = ["D", "T201", "INP001"]
 
# [tool.ruff.lint.per-file-ignores]
# "tests/**/*.py" = ["ANN201", "S101"]
 
# [tool.ruff.format]
# quote-style = "double"
# indent-style = "space"
# line-ending = "lf"
 
# # [tool.ruff.lint.isort]
# # known-first-party = ["$PROJECT_DIR_NAME"]
 
# [tool.pyright]
# typeCheckingMode = "standard"
# pythonVersion = "$PYTHON_VERSION_NUMBER"
# include = ["src"] 
# exclude = [
#   "**/venv",
#   "**/.venv",
#   "**/env",
#   "**/.env",
#   "**/node_modules",
#   "**/__pycache__",
# ]
# venv = ".venv"
# venvPath = "."
# executionEnvironments = [{ root = "src" }]
# useLibraryCodeForTypes = true
# reportMissingImports = true
# reportMissingTypeStubs = true
# stubPath = "stubs"
 
# [tool.pytest.ini_options]
# addopts = "-s --color=yes --tb=short"
# pythonpath = ["src"]
# testpaths = ["tests"]
EOF
