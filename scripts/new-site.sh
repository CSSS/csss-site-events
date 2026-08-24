#!/bin/bash
set -e

UI_DIR="@csss-site-events/ui"
FAVICON_DIR="packages/ui/assets/favicons"

EVENT=$1 # e.g. fall-hacks, frosh, madness, tech-fair
YEAR=$2  # e.g. 2026

if [ -z "$EVENT" ] || [ -z "$YEAR" ]; then
  echo "Usage: ./scripts/new-site.sh <event> <year>"
  exit 1
fi

NAME="$EVENT-$YEAR"
# Converts the name from kebab case to title case e.g. `my-event-20XX` to `My Event 20XX`
PROPER_NAME=$(echo "$EVENT-$YEAR" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2); print}')
DIR="sites/$EVENT/$YEAR"

echo "Creating $NAME at $DIR..."

mkdir -p "$DIR/src/"{pages,components,layouts,config}
mkdir -p "$DIR/public"

# astro.config.mjs
cat >"$DIR/astro.config.mjs" <<EOF
import { defineSiteConfig } from '../../../astro.shared.mjs';

const isLocal = process.env.LOCAL === 'true';
const isProd = process.env.NODE_ENV === 'production' && !isLocal;

export default defineSiteConfig({
  base: isProd ? '/' : '/$YEAR',
  site: 'https://$EVENT.sfucsss.org/$YEAR',
  outDir: './dist',
  build: {
    assets: 'assets',
  },
});
EOF

# package.json
cat >"$DIR/package.json" <<EOF
{
  "name": "$NAME",
  "version": "0.0.1",
  "private": true,
  "scripts": {
    "dev": "astro dev",
    "build": "astro build",
    "preview": "astro preview"
  },
  "dependencies": {
    "$UI_DIR": "*",
    "astro": "^7.0.0"
  }
}
EOF

# project.json
cat >"$DIR/project.json" <<EOF
{
  "name": "$NAME",
  "\$schema": "../../../node_modules/nx/schemas/project-schema.json",
  "projectType": "application",
  "tags": ["type:site", "event:$EVENT", "year:$YEAR"],
  "targets": {
    "build": {
      "executor": "nx:run-commands",
      "options": {
        "command": "astro build",
        "cwd": "$DIR"
      },
      "outputs": ["{projectRoot}/dist"]
    },
    "dev": {
      "executor": "nx:run-commands",
      "options": {
        "command": "astro dev",
        "cwd": "$DIR"
      }
    },
    "preview": {
      "executor": "nx:run-commands",
      "options": {
        "command": "astro preview",
        "cwd": "$DIR"
      }
    }
  }
}
EOF

# tsconfig.json
cat >"$DIR/tsconfig.json" <<EOF
{
  "extends": "../../../tsconfig.json",
  "include": ["src"]
}
EOF

# Default site data
cat >"$DIR/src/config/site.data.ts" <<EOF
import type { NavItem, SiteConfig } from '$UI_DIR/types';

export const navItems: NavItem[] = [
  {
    label: 'Link',
    href: '#content'
  },
  {
    label: 'Dropdown',
    children: [
      {
        label: 'Link 1',
        href: 'link/to/1'
      }
    ]
  }
]

export const siteConfig: SiteConfig = {
  name: '$PROPER_NAME',
  title: '$PROPER_NAME',
  description: 'Description',
  eventName: '$PROPER_NAME'
}
EOF

# Default layout extending @csss-site-events/ui
cat >"$DIR/src/layouts/Layout.astro" <<EOF
---
import '$UI_DIR/styles/font-faces/cal-sans.css';
import '$UI_DIR/styles/font-faces/geist-mono.css';
import '../styles.css';

import calSansFont from '$UI_DIR/assets/fonts/cal-sans-v2-latin-regular.woff2?url';
import geistMonoRegularFont from '$UI_DIR/assets/fonts/geist-mono-v6-latin-regular.woff2?url';
import Footer from '$UI_DIR/components/Footer.astro';
import Hero from '$UI_DIR/components/Hero.astro';
import Navbar from '$UI_DIR/components/Navbar.astro';
import BaseLayout from '$UI_DIR/layouts/BaseLayout.astro';
import type { ImageMetadata } from 'astro';

import { navItems, siteConfig } from '../config/site.data';

interface Props {
  title: string;
  heroImage?: ImageMetadata;
  heroAlt?: string;
  isFullHeightHero?: boolean;
}

const { title, heroImage, heroAlt, isFullHeightHero = false } = Astro.props;
const hasHero = heroImage || Astro.slots.hero;
---

<BaseLayout pageTitle={title} description={siteConfig.description}>
  <Fragment slot="head">
    <link rel="preload" href={calSansFont} as="font" type="font/woff2" crossorigin />
    <link rel="preload" href={geistMonoRegularFont} as="font" type="font/woff2" crossorigin />
  </Fragment>
  <Navbar title={title} items={navItems} />
  {
    hasHero ? (
      <Hero image={heroImage} alt={heroAlt} isFullHeight={isFullHeightHero}>
        <slot name="hero" />
      </Hero>
    ) : (
      <slot name="hero" />
    )
  }
  <main class="content-grid full-width">
    <slot />
  </main>
  <Footer config={siteConfig} navItems={navItems} />
</BaseLayout>

<style>
  main {
    row-gap: var(--section-gap);
    padding: var(--sp-6);
  }

  footer {
    margin-top: var(--sp-6);
  }
</style>
EOF

# Default index page
cat >"$DIR/src/pages/index.astro" <<EOF
---
import { siteConfig } from '../config/site.data';
import Layout from '../layouts/Layout.astro';
---

<Layout title={siteConfig.title}>
  <h1 id="content">{siteConfig.title}</h1>
</Layout>
EOF

cp "$FAVICON_DIR/apple-touch-icon.png" "$DIR/public/apple-touch-icon.png"
cp "$FAVICON_DIR/favicon-96x96.png" "$DIR/public/favicon-96x96.png"
cp "$FAVICON_DIR/favicon.ico" "$DIR/public/favicon.ico"
cp "$FAVICON_DIR/favicon.svg" "$DIR/public/favicon.svg"
cp "$FAVICON_DIR/site.webmanifest" "$DIR/public/site.webmanifest"
cp "$FAVICON_DIR/web-app-manifest-192x192.png" "$DIR/public/web-app-manifest-192x192.png"
cp "$FAVICON_DIR/web-app-manifest-512x512.png" "$DIR/public/web-app-manifest-512x512.png"

# robots.txt
# Sitemap is generated when the site is built
cat >"$DIR/public/robots.txt" <<EOF
User-agent: *
Allow: /

Sitemap: https://$EVENT.sfucsss.org/sitemap-index.xml
EOF

# Global styles
cat >"$DIR/src/styles.css" <<EOF
/* Place global styles here */
EOF

echo "Done. Run: nx dev $NAME"
