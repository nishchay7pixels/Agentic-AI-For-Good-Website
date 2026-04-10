import { createServerSupabaseClient } from '@/lib/supabase-server'
import ToolDetail from '@/views/ToolDetail'
import type { Metadata } from 'next'
import { notFound } from 'next/navigation'

interface Props {
  params: Promise<{ slug: string }>
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { slug } = await params
  const supabase = createServerSupabaseClient()
  const { data: tool } = await supabase
    .from('tools')
    .select('name, description, logo_url, tagline, category, pricing')
    .eq('slug', slug)
    .eq('approved', true)
    .single()

  if (!tool) return { title: 'Tool Not Found' }

  const title = `${tool.name} — AI Tool | Agentic AI For Good`
  const description = tool.tagline ?? tool.description

  return {
    title,
    description,
    openGraph: {
      title: `${tool.name} — AI Tool`,
      description,
      url: `https://agenticaiforgood.com/tools/${slug}`,
      siteName: 'Agentic AI For Good',
      images: tool.logo_url
        ? [{ url: tool.logo_url, alt: tool.name }]
        : [{ url: 'https://agenticaiforgood.com/og-image.png', width: 1200, height: 630 }],
      type: 'website',
    },
    twitter: {
      card: 'summary',
      title: `${tool.name} — AI Tool`,
      description,
      images: tool.logo_url ? [tool.logo_url] : ['https://agenticaiforgood.com/og-image.png'],
    },
    alternates: {
      canonical: `https://agenticaiforgood.com/tools/${slug}`,
    },
  }
}

export default async function ToolDetailPage({ params }: Props) {
  const { slug } = await params
  const supabase = createServerSupabaseClient()
  const { data: tool } = await supabase
    .from('tools')
    .select('*')
    .eq('slug', slug)
    .eq('approved', true)
    .single()

  if (!tool) notFound()

  const jsonLd = {
    '@context': 'https://schema.org',
    '@type': 'SoftwareApplication',
    name: tool.name,
    description: tool.tagline ?? tool.description,
    url: tool.url,
    applicationCategory: 'DeveloperApplication',
    operatingSystem: 'Web',
    offers: {
      '@type': 'Offer',
      price: tool.pricing === 'free' ? '0' : undefined,
      priceCurrency: 'USD',
      availability: 'https://schema.org/OnlineOnly',
    },
  }

  return (
    <>
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
      />
      <ToolDetail tool={tool} />
    </>
  )
}
