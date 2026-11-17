---
name: troubleshoot
description: Diagnose ManageLM connection problems, missing tools, offline servers and failed tasks. Use when the user reports an error or unexpected behavior with ManageLM in ChatGPT or Codex.
---

# ManageLM troubleshooting

Work through these checks in order and stop when you find the cause.

## 1. Connection and sign-in

- **Sign-in fails or tools answer "unauthorized"**: the sign-in did not complete, or the access was revoked (for example after the user reset their MCP credentials in Portal > Settings > MCP & API, or an admin revoked MCP access). Have the user open the ManageLM plugin in ChatGPT's Plugins page, disconnect it and connect again.
- **Forbidden from every tool**: the user may have an MCP / API Key IP whitelist in Portal > Settings > MCP & API. ChatGPT calls ManageLM from OpenAI's servers, so OpenAI's egress IP ranges must be in that list, or the list emptied.
- **Self-hosted portal not reachable**: the custom MCP server URL must be the portal's MCP address ending with `/mcp`, served over HTTPS and reachable from the internet, because ChatGPT connects from OpenAI's servers. A portal kept on a private network can publish only its MCP and OAuth endpoints with `PUBLIC_URL` (see the portal documentation) and use `<PUBLIC_URL>/mcp`.

## 2. Servers

- Call `search_agents` with no filters to see every server the user can access.
- **No servers listed**: no agent is enrolled and approved yet, or the user's role restricts which servers they see.
- **Server offline**: the agent service is stopped or cannot reach the portal. On Linux, check `systemctl status managelm-agent` on the server; on Windows, check the ManageLM agent service in Services. The agent connects outbound only, so check outbound HTTPS from the server to the portal.

## 3. Tasks

- `get_task_status` with the task ID shows the detailed status and error.
- `get_task_history` shows recent tasks on that server and any pattern of failures.
- **Skill not available**: `get_agent_skills` shows whether the skill is assigned to the server. Skills are assigned in the portal.
- **Task limit reached**: the account's daily task limit is used up; `get_account_info` shows plan limits and usage. Searches do not count against it.
- **Permission denied on the server**: the agent lacks the OS-level rights for that action.

## 4. Missing tools

- Skill tools exist only for skills imported into the account; `list_available_skills` shows catalog skills not imported yet. An account set to No LLM has no skill tools.
- Some search tools appear only when their feature is enabled on the account, and the hosting tools only once a hosting connector exists.
- After skills or features change, have the user refresh the ManageLM connection in ChatGPT's Plugins page and start a new conversation.
