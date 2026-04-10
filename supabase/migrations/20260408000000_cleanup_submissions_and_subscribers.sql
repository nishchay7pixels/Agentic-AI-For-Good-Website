-- ============================================================
-- Migration: Drop tool_submissions, clean tools, add subscribers
-- Date: 2026-04-08
-- ============================================================

-- 1. Drop tool_submissions table (PII risk, replaced by GH PR workflow)
DROP POLICY IF EXISTS "Anyone can submit a tool" ON tool_submissions;
DROP POLICY IF EXISTS "Service role manages submissions" ON tool_submissions;
DROP INDEX IF EXISTS tool_submissions_status_idx;
DROP INDEX IF EXISTS tool_submissions_created_at_idx;
DROP TABLE IF EXISTS tool_submissions;

-- 2. Drop unused column from tools
ALTER TABLE tools DROP COLUMN IF EXISTS submitted_by;

-- 3. Create subscribers table (exists in prod but has no migration file)
CREATE TABLE IF NOT EXISTS subscribers (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  email text UNIQUE NOT NULL,
  source text DEFAULT 'website',
  created_at timestamptz DEFAULT now()
);

ALTER TABLE subscribers ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Service role full access on subscribers"
  ON subscribers FOR ALL
  USING (auth.role() = 'service_role');

CREATE POLICY "Anyone can subscribe"
  ON subscribers FOR INSERT
  WITH CHECK (true);

CREATE INDEX IF NOT EXISTS subscribers_email_idx ON subscribers (email);
CREATE INDEX IF NOT EXISTS subscribers_created_at_idx ON subscribers (created_at DESC);
