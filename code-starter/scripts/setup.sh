#!/usr/bin/env bash
# Gets a new teammate's macOS/Linux machine ready to work on this project.
# See code-starter/README.md for what this is (and isn't) meant to do.
set -euo pipefail

echo "==> Checking for required tools..."
command -v git >/dev/null 2>&1 || { echo "git is required but not installed. Aborting." >&2; exit 1; }

echo "==> Copying .env.example to .env (if it doesn't already exist)..."
if [ ! -f .env ]; then
  cp code-starter/.env.example .env
  echo "    Created .env — fill in real values before running the app."
else
  echo "    .env already exists, skipping."
fi

echo "==> Installing pre-commit hooks (if pre-commit is installed)..."
if command -v pre-commit >/dev/null 2>&1; then
  cp code-starter/.pre-commit-config.yaml .pre-commit-config.yaml 2>/dev/null || true
  pre-commit install
else
  echo "    pre-commit not found. Install it with: pip install pre-commit"
fi

# TODO: add your stack's actual dependency install command, e.g.:
#   npm ci
#   pip install -r requirements.txt
#   go mod download

echo "==> Setup complete. See README.md for how to run the project."
