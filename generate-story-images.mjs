// Generates square story cover images that mirror the Canva social-post direction.
// Usage: node generate-story-images.mjs
import puppeteer from 'puppeteer';
import { mkdirSync, readFileSync } from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const stories = JSON.parse(readFileSync('stories.json', 'utf-8'));

const CANVAS_SIZE = 1080;
const categoryColors = {
  'Developer Tools': '#D4754E',
  'Open Source AI': '#7A8E70',
  'Document Intelligence': '#6B84A6',
  'Robotics & Physical AI': '#8572A6',
  'Enterprise AI': '#B96D49',
  'AI Safety & Evaluation': '#5E8B7E',
  'Open Data': '#8A7B68',
};

function escapeHtml(value) {
  return value
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;');
}

function getTitleMetrics(title) {
  if (title.length > 88) return { fontSize: 68, lineHeight: 1.05, maxWidth: 760 };
  if (title.length > 64) return { fontSize: 76, lineHeight: 1.05, maxWidth: 780 };
  return { fontSize: 84, lineHeight: 1.02, maxWidth: 800 };
}

function makeHtml(story) {
  const accent = categoryColors[story.category] || '#D4754E';
  const { fontSize, lineHeight, maxWidth } = getTitleMetrics(story.title);
  const category = escapeHtml((story.category || 'Agentic AI For Good').toUpperCase());
  const company = story.company ? escapeHtml(story.company) : '';
  const title = escapeHtml(story.title);

  return `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Inter:wght@500;700;800;900&display=swap');
    * { box-sizing: border-box; margin: 0; padding: 0; }
    html, body {
      width: ${CANVAS_SIZE}px;
      height: ${CANVAS_SIZE}px;
      overflow: hidden;
    }
    body {
      position: relative;
      background:
        radial-gradient(circle at 88% 10%, rgba(255,255,255,0.05), transparent 22%),
        radial-gradient(circle at 84% 18%, ${accent}22, transparent 16%),
        radial-gradient(circle at 18% 88%, rgba(255,255,255,0.035), transparent 18%),
        #171717;
      color: #F5F1EB;
      font-family: 'Inter', sans-serif;
    }
    .orb {
      position: absolute;
      border-radius: 999px;
      pointer-events: none;
      filter: blur(1px);
    }
    .orb.primary {
      width: 326px;
      height: 326px;
      top: -44px;
      right: -36px;
      background: ${accent};
      opacity: 0.12;
    }
    .orb.secondary {
      width: 214px;
      height: 214px;
      right: 154px;
      top: 78px;
      background: ${accent};
      opacity: 0.07;
    }
    .orb.tertiary {
      width: 186px;
      height: 186px;
      left: -58px;
      bottom: -48px;
      background: rgba(255,255,255,0.05);
      opacity: 0.85;
    }
    .frame {
      position: relative;
      width: 100%;
      height: 100%;
      padding: 64px 68px 68px;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }
    .eyebrow {
      display: flex;
      align-items: baseline;
      gap: 12px;
      color: ${accent};
      font-size: 18px;
      font-weight: 700;
      letter-spacing: 0.18em;
      text-transform: uppercase;
      max-width: 860px;
    }
    .company {
      color: rgba(245,241,235,0.55);
      font-size: 16px;
      font-weight: 500;
      letter-spacing: 0;
      text-transform: none;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
      flex: 1;
    }
    .content {
      display: flex;
      flex-direction: column;
      gap: 30px;
      margin-top: 26px;
    }
    .title {
      max-width: ${maxWidth}px;
      font-size: ${fontSize}px;
      font-weight: 900;
      line-height: ${lineHeight};
      letter-spacing: -0.04em;
      text-wrap: balance;
    }
    .accent-line {
      width: 68px;
      height: 4px;
      border-radius: 999px;
      background: ${accent};
      opacity: 0.95;
    }
    .footer {
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 20px;
      color: rgba(245,241,235,0.36);
      font-size: 17px;
      font-weight: 600;
      letter-spacing: 0.14em;
      text-transform: uppercase;
    }
    .footer-mark {
      display: flex;
      align-items: center;
      gap: 12px;
    }
    .footer-dot {
      width: 10px;
      height: 10px;
      border-radius: 999px;
      background: ${accent};
    }
  </style>
</head>
<body>
  <div class="orb primary"></div>
  <div class="orb secondary"></div>
  <div class="orb tertiary"></div>
  <div class="frame">
    <div>
      <div class="eyebrow">
        <span>${category}</span>
        ${company ? `<span class="company">${company}</span>` : ''}
      </div>
      <div class="content">
        <div class="title">${title}</div>
        <div class="accent-line"></div>
      </div>
    </div>
    <div class="footer">
      <div class="footer-mark">
        <span class="footer-dot"></span>
        <span>Agentic AI For Good</span>
      </div>
      <span>Story Cover</span>
    </div>
  </div>
</body>
</html>`;
}

async function generate() {
  mkdirSync(path.join(__dirname, 'public', 'images', 'stories'), { recursive: true });
  const browser = await puppeteer.launch({ headless: true });

  for (const story of stories) {
    const page = await browser.newPage();
    await page.setViewport({ width: CANVAS_SIZE, height: CANVAS_SIZE, deviceScaleFactor: 1 });
    await page.setContent(makeHtml(story), { waitUntil: 'networkidle0' });

    const outPath = path.join(__dirname, 'public', 'images', 'stories', `${story.slug}.png`);
    await page.screenshot({ path: outPath, type: 'png' });
    await page.close();
    console.log(`Generated: ${story.slug}.png`);
  }

  await browser.close();
  console.log('\nAll story images generated.');
}

generate();
