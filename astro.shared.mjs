import Compress from '@playform/compress';
import { defineConfig } from 'astro/config';

export function defineSiteConfig(config, compressOptions = {}) {
  return defineConfig({
    ...config,
    build: {
      inlineStylesheets: 'always',
      ...(config.build ?? {})
    },
    integrations: [...(config.integrations ?? []), Compress(compressOptions)]
  });
}
