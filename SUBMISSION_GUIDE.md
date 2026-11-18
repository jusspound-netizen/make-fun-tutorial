# Submission Guide — `bring-the-humans-02`

End-to-end checklist to prepare, publish, and submit a make.fun "Bring the humans again" entry.

> **Important:** This folder may already contain a drafted README for a specific entrant/referral link. If you are entering **yourself**, replace the referral link in `README.md` with **your own** before submitting (use `node cli/makefun.mjs referrals` from the bounty kit). If you submit someone else's referral link, signups will count for them, not you.

## 0. Prerequisites

Before you start, make sure you have:

- A make.fun account with GitHub linked
- A Solana wallet linked (needed to claim winnings)
- `opencode` installed (or another session-recording harness)
- An active `makefun` login/API key (`makefun login`, verify with `makefun whoami`)
- The bounty kit for `bring-the-humans-02`

If anything is missing, complete Steps 1–4 in [README.md](README.md) first.

## 1. Confirm the README has *your* referral link

For this bounty, your README must include your own `https://make.fun/r/<code>` link.

1. From inside the `bring-the-humans-02-kit/` directory, print your code/link:
   ```bash
   node cli/makefun.mjs referrals
   ```
2. Replace the referral URL in `README.md` with your own (every occurrence). Example:
   ```bash
   # Replace the existing link with your own
   sed -i 's|https://make.fun/r/[^ )"\`]*|https://make.fun/r/<your-code>|g' README.md
   ```
3. Verify:
   ```bash
   grep -n "https://make.fun/r/" README.md
   ```
4. (Optional) Update the copyright name in [LICENSE](LICENSE).

## 2. Create the GitHub repository

1. Go to https://github.com/new
2. Create a **public** repository (required)
3. Do **not** initialize it with a README/license/gitignore if you plan to push this folder as the initial commit
4. Note the repo URL (you'll need it for `check`/`submit`)

The bounty requires a public repo created after the bounty opened and meeting the live deliverables — confirm details in the requirements endpoint.

## 3. Author/edit files in a real AI coding session

The bounty expects a **real AI coding-agent transcript** of the session that produced the work. Do not hand-edit session logs.

1. Run your harness in this repo (recommended: `opencode`).
2. Have the agent read and improve `README.md`, `LICENSE`, `TRANSCRIPT.md`, and this guide as needed.
3. Keep the README clear, accurate, and under the bounty's limits (for this repo, keep under ~1,800 words and preserve the quick-start table).
4. Ensure deliverables are satisfied (license, referral link, screenshot plan, etc.).

The harness's on-disk session log is what `node cli/makefun.mjs bundle` collects.

## 4. Commit and push the repo

From this repository directory:

```bash
git init -b main
git add README.md LICENSE TRANSCRIPT.md SUBMISSION_GUIDE.md
git commit -m "Initial entry for bring-the-humans-02"

git remote add origin https://github.com/<you>/<your-repo>.git
git push -u origin main
```

Follow the bounty's guidance on commit history/state (many bounties expect a clean, pinned submission state).

## 5. Take `screenshot.png`

Capture a screenshot of the **GitHub repo page** showing the rendered README.

- Save as `screenshot.png` in the repo root
- Use PNG/JPEG/WebP and keep it under the size limit stated in requirements
- Make sure the repo name and rendered README content are clearly visible

Add and push it (keeping history clean if required):

```bash
git add screenshot.png
git commit --amend --no-edit   # optional, if you need a single-commit state
git push --force-with-lease
```

## 6. Fetch the bounty kit (if needed)

```bash
curl -sSL "https://make.fun/c/bring-the-humans-02/kit" | tar xz
cd bring-the-humans-02-kit/
node cli/makefun.mjs --help
```

Run all kit commands from inside the kit directory unless the command docs say otherwise.

## 7. Read live requirements

```bash
curl -s "https://make.fun/api/competitions/bring-the-humans-02/requirements" | jq
```

Verify every **prerequisite** and **deliverable** yourself before submitting.

## 8. Bundle the transcript

```bash
# From inside bring-the-humans-02-kit/
node cli/makefun.mjs bundle
# If needed, point it at your repo/session per `--help`
```

This produces `bundle.zip` (or similar, per CLI output). If bundling fails, ensure you used a supported harness with on-disk session logs and did the work in that session.

## 9. Run local checks

```bash
node cli/makefun.mjs check bring-the-humans-02 \
  --repo https://github.com/<you>/<your-repo> \
  --transcript ./bundle.zip
```

Fix every failure before submitting. This helps avoid wasting daily submission attempts.

## 10. Submit

```bash
node cli/makefun.mjs submit bring-the-humans-02 \
  --repo https://github.com/<you>/<your-repo> \
  --transcript ./bundle.zip
```

Confirm exact flags with `node cli/makefun.mjs submit --help` (CLI behavior may change). Save the returned submission ID.

## 11. Monitor status

```bash
node cli/makefun.mjs status
```

If checks fail, address the reported issue, re-bundle/re-check as needed, and resubmit within your quota.

## 12. Promote your referral link

For this bounty, verified human signups via **your** referral link drive scoring. Share your link in relevant communities, pin the repo, and make the README genuinely useful so people trust and use it.

## Common failures and fixes

| Symptom | Likely cause | Fix |
|---|---|---|
| `bundle` finds no session | Harness not run / wrong location / no on-disk log | Run a supported harness in the repo and re-run `bundle` (check `--help`) |
| Transcript/wellformed checks fail | Hand-edited or incompatible logs | Use unmodified logs from a supported harness that records required fields |
| Missing deliverables | Repo/license/README/screenshot/referral link incomplete | Re-read `/requirements` and fix every item |
| 401 Unauthorized | Expired/missing `makefun` API key | Run `makefun login` again and retry |
| 429 / quota closed | Rate limit or daily cap reached | Wait for retry window / UTC reset |

For issues with the platform or kit, use the kit feedback command (see `node cli/makefun.mjs feedback --help`).
