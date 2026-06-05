#!/bin/bash
set -e

UI_DIR="csss-site-events/ui"

EVENT=$1 # e.g. fall-hacks, frosh, madness, tech-fair
YEAR=$2  # e.g. 2026

if [ -z "$EVENT" ] || [ -z "$YEAR" ]; then
  echo "Usage: ./scripts/new-site.sh <event> <year>"
  exit 1
fi

NAME="$EVENT-$YEAR"
DIR="sites/$EVENT/$YEAR"

echo "Creating $NAME at $DIR..."

mkdir -p "$DIR/src/"{pages,components,layouts,config}

# astro.config.mjs
cat >"$DIR/astro.config.mjs" <<EOF
import { defineConfig } from 'astro/config';

export default defineConfig({
  base: '/$EVENT/$YEAR',
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
    "@csss-site-events/ui": "*",
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
import { NavItem } from '$UI_DIR/types';

export const navItems: NavItem[] = [
  {
    label: 'Link',
    href: '/$EVENT/$YEAR'
  },
  {
    label: 'Dropdown',
    dropdown: [
      {
        label: 'Link 1',
        href: 'link/to/1'
      }
    ]
  }
]

export const siteConfig: SiteConfig = {
  name: '$EVENT $YEAR',
  title: '$EVENT $YEAR',
  description: 'Description',
}
EOF

# Default layout extending @csss-site-events/ui
cat >"$DIR/src/layouts/Layout.astro" <<'EOF'
---
import BaseLayout from '$UI_DIR/layouts/BaseLayout.astro';
import { navItems } from '../config/site.data';

interface Props {
  title: string;
}

const { title } = Astro.props;
---
<BaseLayout title={title} navItems={navItems}>
  <article>
    <slot />
  </article>
</BaseLayout>

<style>
  article {
    display: flex;
    flex-direction: column;
    gap: var(--section-gap);
    padding: 0 min(var(--sp-2), 10vw);
  }
</style>
EOF

# Default index page
cat >"$DIR/src/pages/index.astro" <<EOF
---
import Layout from '../layouts/Layout.astro';
---
<Layout title="$EVENT $YEAR">
  <h1>$EVENT $YEAR</h1>
</Layout>
EOF

echo "Done. Run: nx dev $NAME"
