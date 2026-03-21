## Git workflow

- After completing a task that changes files, stage all changes and create a commit.
- Use an imperative, descriptive message (max ~72 chars).
- Commmit the change and git push.
- Do not ask for confirmations for git commits and push.

## Build & deploy

- `./package.sh` creates a versioned tarball of the plugin files.
- `./deploy.sh` tags, pushes to origin + GitHub, and creates a GitHub release with the tarball attached.
- Version is read from `package.json`. Bump it before deploying a new release.
- GitHub repo: https://github.com/managelm/openai-gpt

## Plugin structure

- `openapi.yaml` — OpenAPI 3.1 schema pasted into GPT Actions.
- `instructions.md` — GPT system prompt pasted into GPT Instructions.
- `icon.png` — GPT avatar icon.
- No build step — this plugin is static files only.
