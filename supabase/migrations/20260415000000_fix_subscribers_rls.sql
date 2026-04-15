-- Fix RLS policies for subscribers table to allow public inserts

DROP POLICY IF EXISTS "Anyone can subscribe" ON subscribers;
DROP POLICY IF EXISTS "Service role full access on subscribers" ON subscribers;

-- Service role has full access
CREATE POLICY "Service role full access on subscribers"
  ON subscribers FOR ALL
  TO service_role
  USING (true)
  WITH CHECK (true);

-- Anonymous and authenticated users can insert (subscribe)
CREATE POLICY "Public can insert subscribers"
  ON subscribers FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);
