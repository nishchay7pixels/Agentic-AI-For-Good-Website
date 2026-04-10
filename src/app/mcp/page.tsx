import { Suspense } from 'react'
import MCPPage from '@/views/MCPPage'
import type { Metadata } from 'next'

export const metadata: Metadata = {
  title: 'MCP Server — Use AI Tool Catalog Inside Claude | Agentic AI For Good',
  description:
    'Install the agentic-ai-for-good-mcp server to give Claude access to 200+ curated AI tools. Search by use case, get stack-aware recommendations, and discover new tools — without leaving your IDE.',
  keywords: [
    'MCP server',
    'Claude MCP',
    'AI tools catalog',
    'Model Context Protocol',
    'Claude plugin',
    'AI tool discovery',
    'agentic AI',
  ],
  openGraph: {
    title: 'MCP Server — Use AI Tool Catalog Inside Claude',
    description:
      'Give Claude access to 200+ curated AI tools. Search by use case, get stack-aware recommendations, and discover new tools — without leaving your IDE.',
    url: 'https://agenticaiforgood.com/mcp',
    siteName: 'Agentic AI For Good',
    images: [
      {
        url: 'https://agenticaiforgood.com/og-image.png',
        width: 1200,
        height: 630,
        alt: 'Agentic AI For Good MCP Server',
      },
    ],
    type: 'website',
  },
  twitter: {
    card: 'summary_large_image',
    title: 'MCP Server — Use AI Tool Catalog Inside Claude',
    description:
      'Give Claude access to 200+ curated AI tools via MCP. Search by use case, get stack-aware recommendations.',
    images: ['https://agenticaiforgood.com/og-image.png'],
  },
  alternates: {
    canonical: 'https://agenticaiforgood.com/mcp',
  },
}

export default function Page() {
  return (
    <Suspense>
      <MCPPage />
    </Suspense>
  )
}
