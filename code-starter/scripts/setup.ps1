# Gets a new teammate's Windows machine ready to work on this project.
# See code-starter/README.md for what this is (and isn't) meant to do.
$ErrorActionPreference = "Stop"

Write-Host "==> Checking for required tools..."
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Error "git is required but not installed. Aborting."
    exit 1
}

Write-Host "==> Copying .env.example to .env (if it doesn't already exist)..."
if (-not (Test-Path ".env")) {
    Copy-Item "code-starter\.env.example" ".env"
    Write-Host "    Created .env - fill in real values before running the app."
} else {
    Write-Host "    .env already exists, skipping."
}

Write-Host "==> Installing pre-commit hooks (if pre-commit is installed)..."
if (Get-Command pre-commit -ErrorAction SilentlyContinue) {
    Copy-Item "code-starter\.pre-commit-config.yaml" ".pre-commit-config.yaml" -ErrorAction SilentlyContinue
    pre-commit install
} else {
    Write-Host "    pre-commit not found. Install it with: pip install pre-commit"
}

# TODO: add your stack's actual dependency install command, e.g.:
#   npm ci
#   pip install -r requirements.txt
#   go mod download

Write-Host "==> Setup complete. See README.md for how to run the project."
