import { defineConfig } from 'astro/config';

const isProd = import.meta.env.PROD;

export default defineConfig({
  base: isProd ? '/' : '/tech-fair/2026',
  site: 'https://tech-fair.sfucsss.org',
  outDir: './dist',
  build: {
    assets: 'assets',
  },
});
