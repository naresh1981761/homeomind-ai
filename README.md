# HomeoMind AI — Private Clinic Beta

Deployable Next.js + Supabase starter. It is a **clinical documentation demo**, not a medical device or prescribing engine. No licensed repertory, speech recognition, or external AI integration is included.

## 1. Supabase
1. Create a project at https://supabase.com/dashboard.
2. In SQL Editor, execute `supabase/schema.sql`.
3. In Authentication > Providers, enable Email; disable public signups after creating your account.
4. In Authentication > Users, create/invite ONLY your clinic doctor account. Require a strong password; enable MFA if available. Never share credentials.
5. Copy project URL and **publishable/anon** key from Project Settings / API. **Never** use the service-role key in frontend variables.

## 2. Local run
Requires Node.js 20+.
```bash
npm install
cp .env.example .env.local
# edit .env.local with real Supabase project URL and publishable/anon key
npm run dev
```
Open http://localhost:3000/login. Run `npm run build` before deployment.

## 3. Vercel deployment
1. Create a private GitHub repository and upload this project's contents (do not upload `.env.local`).
2. At https://vercel.com/new import the repository as a Next.js project.
3. Add environment variables `NEXT_PUBLIC_SUPABASE_URL` and `NEXT_PUBLIC_SUPABASE_ANON_KEY` from your Supabase project.
4. Deploy, then open `https://YOUR-PROJECT.vercel.app/login` and sign in with the account you created in Supabase.
5. Optional: Vercel Project > Settings > Domains > add a purchased custom domain and follow its DNS records. HTTPS is automatically configured after DNS verification.
6. In Supabase Authentication > URL Configuration set Site URL to the final HTTPS domain. Configure allowed redirect URLs if you later add password reset/email flows.

## 4. IMPORTANT before real patients
- This beta is **not approved for real patient records** until a security/privacy review. A URL is public even though database reads are login-gated. Configure deployment-level access controls if you need an entirely private preview.
- Review India DPDP requirements, patient notice and consent, medical confidentiality, retention/deletion, audit logging, data residency, backups, breach response, MFA and role-based access. Ensure hosting vendors and agreements are suitable.
- Turn off public signup, enable MFA, set up backups, rate limiting, monitoring and security tests before production.
- The `/api/analyze` endpoint is a public, non-persistent keyword demonstration. Do not submit real patient text until endpoint authentication, abuse controls and privacy checks are implemented.
- Do not use the demo scores for remedy prescribing; they are synthetic examples.
- No actual PDF is stored: browser Print > Save as PDF creates a local report.

## 5. Future development
- Authenticated voice capture with explicit recording consent and secure transcription.
- Versioned licensed repertory and Materia Medica sources with source citations.
- Doctor-approved rubric mappings, missing-information prompts and evidence limitations.
- Structured clinical red-flag checks and conventional medical referral workflow.
- Audit logs, encryption key management, backup/restore tests and consent records.
