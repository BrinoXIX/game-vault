-- Public read-only + authenticated owner writes.
-- First create your owner account in Supabase Auth (Dashboard > Authentication > Users).
-- Replace OWNER_UUID below with your user's UUID from the Auth Users list.
ALTER TABLE public.games ADD COLUMN IF NOT EXISTS local_uid text UNIQUE;
ALTER TABLE public.games ADD COLUMN IF NOT EXISTS data jsonb;
ALTER TABLE public.games ENABLE ROW LEVEL SECURITY;
DO $$ DECLARE pol record; BEGIN
 FOR pol IN SELECT policyname FROM pg_policies WHERE schemaname='public' AND tablename='games'
 LOOP EXECUTE format('DROP POLICY IF EXISTS %I ON public.games', pol.policyname); END LOOP;
END $$;
REVOKE ALL ON public.games FROM anon, authenticated;
GRANT SELECT ON public.games TO anon;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.games TO authenticated;
CREATE POLICY "GameVault public read" ON public.games FOR SELECT TO anon USING (true);
CREATE POLICY "GameVault authenticated owner read" ON public.games FOR SELECT TO authenticated USING (auth.uid() = 'OWNER_UUID'::uuid);
CREATE POLICY "GameVault authenticated owner insert" ON public.games FOR INSERT TO authenticated WITH CHECK (auth.uid() = 'OWNER_UUID'::uuid);
CREATE POLICY "GameVault authenticated owner update" ON public.games FOR UPDATE TO authenticated USING (auth.uid() = 'OWNER_UUID'::uuid) WITH CHECK (auth.uid() = 'OWNER_UUID'::uuid);
CREATE POLICY "GameVault authenticated owner delete" ON public.games FOR DELETE TO authenticated USING (auth.uid() = 'OWNER_UUID'::uuid);
