-- GameVault: safe public viewer access. This deliberately makes anon read-only.
-- Owner write access must use authenticated owner policies/backend, not the anon key.
ALTER TABLE public.games ADD COLUMN IF NOT EXISTS local_uid text UNIQUE;
ALTER TABLE public.games ADD COLUMN IF NOT EXISTS data jsonb;
ALTER TABLE public.games ENABLE ROW LEVEL SECURITY;

-- Remove existing policies (including broad legacy anon/public write policies)
-- so permissive policies cannot accidentally continue allowing edits.
DO $$ DECLARE pol record; BEGIN
  FOR pol IN SELECT policyname FROM pg_policies WHERE schemaname='public' AND tablename='games'
  LOOP EXECUTE format('DROP POLICY IF EXISTS %I ON public.games', pol.policyname); END LOOP;
END $$;
REVOKE INSERT, UPDATE, DELETE, TRUNCATE ON public.games FROM anon;
GRANT SELECT ON public.games TO anon;
CREATE POLICY "GameVault public read" ON public.games FOR SELECT TO anon USING (true);
