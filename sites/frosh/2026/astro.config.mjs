import { defineConfig } from 'astro/config';

const isProd = import.meta.env.PROD;

export default defineConfig({
  base: isProd ? '/' : '/frosh/2026',
  site: 'https://frosh.sfucsss.org',
  outDir: './dist',
  build: {
    assets: 'assets'
  }
});
