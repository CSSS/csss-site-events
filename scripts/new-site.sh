#!/bin/bash
set -e

UI_DIR="@csss-site-events/ui"

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

# astro.config.mjs
cat >"$DIR/astro.config.mjs" <<EOF
import { defineConfig } from 'astro/config';

const isProd = import.meta.env.PROD;

export default defineConfig({
  base: isProd ? '/' : '/$EVENT/$YEAR',
  site: 'https://$EVENT.sfucsss.org',
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
    "astro": "^6.0.0"
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
    href: '/$EVENT/$YEAR'
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
import BaseLayout from '$UI_DIR/layouts/BaseLayout.astro';
import Hero from '$UI_DIR/components/Hero.astro';
import Navbar from '$UI_DIR/components/Navbar.astro';
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
  <main>
    <slot />
  </main>
  <footer></footer>
</BaseLayout>

<style>
  main {
    display: flex;
    flex-direction: column;
    gap: var(--section-gap);
    padding: 0 min(var(--sp-2), 10vw) var(--sp-6);
  }

  footer {
    margin-top: var(--sp-6);
  }
</style>
EOF

# Default index page
cat >"$DIR/src/pages/index.astro" <<EOF
---
import Layout from '../layouts/Layout.astro';
import { siteConfig } from '../config/site.data';
---

<Layout title={siteConfig.title}>
  <h1>{siteConfig.title}</h1>
</Layout>
EOF

echo "Done. Run: nx dev $NAME"
