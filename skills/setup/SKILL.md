---
name: setup
description: Connect ManageLM to ChatGPT or Codex and check that it works. Use right after the plugin is installed, or when the user asks how to set up, connect or sign in to ManageLM.
---

# ManageLM setup

Walk the user through these steps in order, and stop as soon as the connection works.

1. **Account and agents**: ManageLM needs an account (free for up to 10 agents at https://app.managelm.com/register) and the ManageLM agent installed and approved on each server, from the portal's Agents page. Without an approved agent there is nothing to manage yet.

2. **Sign in**: the plugin connects to ManageLM SaaS (`https://app.managelm.com/mcp`). The first time a ManageLM tool runs, ChatGPT opens the ManageLM sign-in page: the user signs in with their ManageLM account (and MFA if enabled) and authorizes access. Nothing has to be generated in the portal first. ChatGPT then acts with that user's own permissions.

3. **Self-hosted portal**: the plugin always points to SaaS. For a self-hosted portal, the user adds their own portal instead: in ChatGPT, open Plugins, select **+**, then **Add custom MCP server**, enter `https://<their portal>/mcp` (it must end with `/mcp`), choose OAuth, and select **Create as a plugin**. ChatGPT connects from OpenAI's servers, so that address must be reachable over HTTPS from the internet. A portal kept on a private network can publish only its MCP and OAuth endpoints with `PUBLIC_URL` and use `<PUBLIC_URL>/mcp`.

4. **Check the connection**: call `search_agents` with no filters and show the servers with their status. Then call `get_account_info` and mention the plan and how many agents are in use.

5. **First steps**: suggest two or three things to try, based on what you found, for example "Which servers have critical security findings?", "Which certificates expire this month?" or "Check the disk usage on <a server you listed>".

If a step fails, use the troubleshoot skill.
