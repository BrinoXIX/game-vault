-- Run this migration in Supabase SQL Editor after your original games table setup.
ALTER TABLE public.games ADD COLUMN IF NOT EXISTS local_uid text UNIQUE;
ALTER TABLE public.games ADD COLUMN IF NOT EXISTS data jsonb;

-- The earlier setup used an unrestricted policy. This simple personal-use sync
-- intentionally allows access using the publishable key. Keep this project private
-- to your own use and do not store sensitive information in it.
