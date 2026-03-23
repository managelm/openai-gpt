# ManageLM — OpenAI GPT Plugin

Manage your Linux servers directly from ChatGPT. Check agent status, run
tasks, trigger security audits, and review inventory — all through natural
language in the ChatGPT interface.

ManageLM connects ChatGPT to your infrastructure through the same portal
API used by the Claude extension, n8n integration, and Slack plugin.

## Features

- **Agent management** — list servers, check status, health metrics, approve pending agents
- **Task execution** — run natural-language instructions on any server using skills
- **Interactive tasks** — when the agent needs input (domain name, password, config choice), GPT asks you and answers the agent automatically
- **Security audits** — trigger and review security findings with severity levels
- **Inventory scans** — discover packages, services, and containers
- **Groups & skills** — view server groups and available capabilities
- **Account overview** — check team members and account details

## Architecture

```
ChatGPT User --> Sign in to ManageLM --> ManageLM Portal API
                 (OAuth 2.0)              /api/*
                      |
                 Bearer (OAuth token)
```

The GPT uses OpenAI Actions (OpenAPI spec) to call the ManageLM portal
REST API directly. Users authenticate with their own ManageLM credentials
via OAuth 2.0. No middleware or proxy is required.

## Setup — SaaS

If you use ManageLM at `app.managelm.com`:

1. Go to [ChatGPT GPT Editor](https://chatgpt.com/gpts/editor)
2. Click **Create a GPT**
3. In the **Configure** tab:
   - **Name**: ManageLM
   - **Description**: Manage Linux servers through ManageLM
   - **Instructions**: paste the contents of [`instructions.md`](instructions.md)
4. Under **Actions**, click **Create new action**:
   - **Authentication**: OAuth
   - **Client ID**: your MCP Client ID from Portal > Settings > MCP & API
   - **Client Secret**: your MCP Client Secret
   - **Authorization URL**: `https://app.managelm.com/oauth/authorize`
   - **Token URL**: `https://app.managelm.com/oauth/token`
   - **Scope**: (leave empty)
   - **Token Exchange Method**: Default (POST request)
   - **Schema**: paste the contents of [`openapi.yaml`](openapi.yaml)
5. Click **Save** (private or share with your team)
6. When users first use the GPT, they'll see a **Sign in to ManageLM**
   button and authenticate with their own ManageLM credentials.

## Setup — Self-Hosted

Same steps as SaaS, with two changes:

1. Edit the `servers` section in `openapi.yaml` before pasting:
```yaml
servers:
  - url: https://your-portal.example.com/api
    description: My ManageLM instance
```

2. Set the OAuth URLs to your portal:
   - **Authorization URL**: `https://your-portal.example.com/oauth/authorize`
   - **Token URL**: `https://your-portal.example.com/oauth/token`

## Get Your OAuth Credentials

1. Log in to your ManageLM portal
2. Go to **Settings > MCP & API**
3. Copy your **Client ID** (`mlm_cid_...`) and **Client Secret** (`mlm_sk_...`)
4. If you don't have credentials yet, click **Regenerate** to create them

## Example Usage

```
> Show me all my servers

> What's the disk usage on web-prod-1?

> Install nginx on staging-web-02

> Run a security audit on db-primary

> Which servers have CPU usage above 80%?

> List running services on lb-01

> Show the last 50 lines of /var/log/syslog on monitoring-1
```

## Files

| File | Purpose |
|------|---------|
| `openapi.yaml` | OpenAPI 3.1 schema — paste into GPT Actions |
| `instructions.md` | GPT system prompt — paste into GPT Instructions |
| `icon.png` | GPT avatar icon |

## Limitations vs Claude Extension

| Feature | GPT | Claude Extension |
|---------|-----|------------------|
| Task execution | Yes (via API Actions) | Yes (via MCP) |
| File upload/download | No | Yes |
| Streaming output | No (request/response) | Yes (SSE) |
| Proactive notifications | No (pull only) | No (pull only) |
| Multi-agent targeting | One at a time | Hostname, group, or "all" |

## Privacy

The GPT authenticates users via OAuth 2.0 and sends requests to the
ManageLM portal API on their behalf. No data is stored by the GPT itself.
All data handling is governed by your ManageLM portal's privacy policy.

If publishing the GPT publicly, you must provide a privacy policy URL in
the GPT editor. See [ManageLM Privacy Policy](https://www.managelm.com/privacy.html).

## Links

- [ManageLM Website](https://www.managelm.com)
- [Documentation](https://www.managelm.com/doc/)
- [GitHub](https://github.com/managelm/openai-gpt)

## License

[MIT](LICENSE)
