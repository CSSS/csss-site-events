import Compress from '@playform/compress';
import { defineConfig } from 'astro/config';

export function defineSiteConfig(config, compressOptions = {}) {
  return defineConfig({
    ...config,
    integrations: [...(config.integrations ?? []), Compress(compressOptions)]
  });
}
