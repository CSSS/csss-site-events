import Compress from '@playform/compress';
import sitemap from '@astrojs/sitemap';
import { defineConfig } from 'astro/config';

export function defineSiteConfig(config, compressOptions = {}) {
  const playformOptions = {
    ...compressOptions,
    CSS: false,
    HTML:
      compressOptions.HTML === false
        ? false
        : {
            ...compressOptions.HTML,
            'html-minifier-terser': {
              ...compressOptions.HTML?.['html-minifier-terser'],
              minifyCSS: false
            }
          }
  };

  return defineConfig({
    ...config,
    build: {
      inlineStylesheets: 'always',
      ...(config.build ?? {})
    },
    integrations: [...(config.integrations ?? []), sitemap(), Compress(playformOptions)]
  });
}
