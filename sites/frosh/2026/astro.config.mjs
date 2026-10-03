import { fontProviders } from 'astro/config';
import { defineSiteConfig } from '../../../astro.shared.mjs';

const isLocal = process.env.LOCAL === 'true';
const isProd = process.env.NODE_ENV === 'production' && !isLocal;

export default defineSiteConfig({
  base: isProd ? '/' : '/2026',
  site: 'https://frosh.sfucsss.org/2026',
  outDir: './dist',
  build: {
    assets: 'assets'
  },
  fonts: [
    {
      provider: fontProviders.fontsource(),
      name: 'Geist Mono',
      cssVariable: '--font-geist-mono',
      styles: ['normal', 'italic'],
      weights: ['400', '700']
    },
    {
      provider: fontProviders.fontsource(),
      name: 'Cal Sans',
      cssVariable: '--font-cal-sans'
    }
  ]
});
