import { defineConfig } from 'astro/config';

export default defineConfig({
  base: '/frosh/2026',
  outDir: './dist',
  build: {
    assets: 'assets',
  },
});
