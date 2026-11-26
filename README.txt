GAME VAULT - PUBLIC VIEWER

This package is a public read-only viewer. Visitors can browse/search/filter the shared collection and view game details. Add/edit/delete and settings controls are hidden.

BEFORE PUBLISHING:
1. Open app.js and set PUBLIC_SUPABASE_URL and PUBLIC_SUPABASE_KEY near the top to your Supabase project URL and anon/publishable key.
2. Run SUPABASE-SETUP.sql in the Supabase SQL Editor. This drops existing policies on public.games and gives anon read-only access. IMPORTANT: this disables anonymous cloud writes. Owner editing needs a separate authenticated owner setup/backend; do not restore anonymous write permissions.
3. Upload the files in the game-vault folder to the GitHub Pages repository.

Visitors do not need Supabase keys or RAWG keys entered. The embedded Supabase publishable/anon key is designed for public client use and is constrained by database permissions/RLS.
