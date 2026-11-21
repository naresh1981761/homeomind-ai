-- Run in Supabase SQL Editor. Private single-doctor beta.
create extension if not exists pgcrypto;
create table if not exists public.cases (
 id uuid primary key default gen_random_uuid(),
 owner_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
 patient_name text not null check (char_length(patient_name) between 1 and 200),
 age integer check (age between 0 and 120),
 sex text not null default '',
 chief_complaints text not null default '',
 mental_generals text not null default '',
 physical_generals text not null default '',
 medical_history text not null default '',
 rubrics jsonb not null default '[]'::jsonb,
 created_at timestamptz not null default now(),
 updated_at timestamptz not null default now()
);
alter table public.cases enable row level security;
revoke all on public.cases from anon;
grant select,insert,update,delete on public.cases to authenticated;
drop policy if exists cases_owner_select on public.cases;
drop policy if exists cases_owner_insert on public.cases;
drop policy if exists cases_owner_update on public.cases;
drop policy if exists cases_owner_delete on public.cases;
create policy cases_owner_select on public.cases for select to authenticated using (owner_id=(select auth.uid()));
create policy cases_owner_insert on public.cases for insert to authenticated with check (owner_id=(select auth.uid()));
create policy cases_owner_update on public.cases for update to authenticated using (owner_id=(select auth.uid())) with check (owner_id=(select auth.uid()));
create policy cases_owner_delete on public.cases for delete to authenticated using (owner_id=(select auth.uid()));
create or replace function public.set_case_updated_at() returns trigger language plpgsql set search_path=public as $$begin new.updated_at=now();return new;end$$;
drop trigger if exists trg_cases_updated_at on public.cases;
create trigger trg_cases_updated_at before update on public.cases for each row execute function public.set_case_updated_at();
