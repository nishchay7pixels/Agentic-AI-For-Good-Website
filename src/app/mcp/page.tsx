import { Suspense } from 'react'
import MCPPage from '@/views/MCPPage'
import type { Metadata } from 'next'

export const metadata: Metadata = {
  title: 'MCP Server — Agentic AI For Good',
  description: 'Use the Agentic AI For Good tool catalog inside Claude via MCP.',
}

export default function Page() {
  return (
    <Suspense>
      <MCPPage />
    </Suspense>
  )
}
