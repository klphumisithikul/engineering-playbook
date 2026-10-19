# Code Starter

## In Plain Terms

Think of this folder like a **hotel toiletry kit**, not a furnished apartment.

A furnished apartment (= a full application boilerplate, like `create-react-app` or a Rails `new` project) hands you walls, furniture, and a working kitchen — but it already decided your layout for you, and ripping it out later is a lot of work.

A toiletry kit hands you the small, useful things everyone needs regardless of which room they end up in: a toothbrush, soap, a razor. You still build/choose the room (your actual application code, your framework, your language), but you're not starting from *nothing* either.

That's what's in here: small, individually useful, copy-paste-able pieces — not a prebuilt app. Each item works no matter what language or framework your new project ends up using.

## What's in the Kit, and Why

| Item | What it's for, in plain terms |
|---|---|
| [`.env.example`](./.env.example) | A labeled list of "settings you'll need to fill in" (database passwords, API keys) — without the actual secret values, so it's safe to commit. Like a packing checklist that says "bring a passport" without photocopying your actual passport. |
| [`.pre-commit-config.yaml`](./.pre-commit-config.yaml) | A tripwire that catches obvious mistakes (trailing whitespace, an accidentally-committed secret, broken YAML) *before* they're committed — like a doormat that catches mud before it gets on the carpet. |
| [`scripts/setup.sh`](./scripts/setup.sh) / [`scripts/setup.ps1`](./scripts/setup.ps1) | A short script that gets a new teammate's laptop ready, whether they use a Mac/Linux (`setup.sh`) or Windows (`setup.ps1`) — like a one-page assembly instruction instead of making every new teammate guess. |

## How to Use It

1. Copy whichever files are relevant into your new project's root.
2. Rename `.env.example` → `.env` locally, fill in real values, and confirm `.env` is in `.gitignore` (it already is, in this template's [`.gitignore`](../.gitignore)).
3. Run `pre-commit install` (requires the [pre-commit](https://pre-commit.com/) framework — `pip install pre-commit`, works regardless of your project's language) to activate the tripwire.
4. Run `scripts/setup.sh` (macOS/Linux) or `scripts/setup.ps1` (Windows) and fill in the `TODO`s with your stack's actual install commands.

## What's Deliberately *Not* Here

Actual application boilerplate (a starter Express server, a starter Django app, etc.) — that's stack-specific by nature, and this template is intentionally stack-agnostic (see [README.md](../README.md)). If you want that, use your framework's own generator (`npm create vite@latest`, `django-admin startproject`, etc.) *and then* layer this kit on top of it.
