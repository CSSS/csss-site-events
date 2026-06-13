import { defineSiteConfig } from '../../../astro.shared.mjs';

const isProd = import.meta.env.PROD;

export default defineSiteConfig({
  base: isProd ? '/' : '/frosh/2026',
  site: 'https://frosh.sfucsss.org',
  outDir: './dist',
  build: {
    assets: 'assets'
  }
});
