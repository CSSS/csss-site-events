import { defineSiteConfig } from '../../../astro.shared.mjs';

const isProd = import.meta.env.PROD;

export default defineSiteConfig({
  base: isProd ? '/' : '/tech-fair/2026',
  site: 'https://tech-fair.sfucsss.org/2026',
  outDir: './dist',
  build: {
    assets: 'assets'
  }
});
