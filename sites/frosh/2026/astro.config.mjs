import { defineSiteConfig } from '../../../astro.shared.mjs';

const isLocal = process.env.LOCAL === 'true';
const isProd = process.env.NODE_ENV === 'production' && !isLocal;

export default defineSiteConfig({
  base: isProd ? '/' : '/frosh/2026',
  site: 'https://frosh.sfucsss.org/2026',
  outDir: './dist',
  build: {
    assets: 'assets'
  }
});
