import eslint from '@eslint/js';
import eslintConfigPrettier from 'eslint-config-prettier/flat';
import eslintPluginAstro from 'eslint-plugin-astro';
import globals from 'globals';
import tseslint from 'typescript-eslint';

export default [
  {
    ignores: [
      '**/.astro/**',
      '**/dist/**',
      '**/node_modules/**',
      '**/public/**',
      '.nx/**',
      'legacy/**',
      'tmp/**'
    ]
  },
  eslint.configs.recommended,
  ...tseslint.configs.recommended,
  ...eslintPluginAstro.configs.recommended,
  ...eslintPluginAstro.configs['jsx-a11y-recommended'],
  {
    files: [
      '*.config.{js,cjs,mjs,ts,cts,mts}',
      '**/*.config.{js,cjs,mjs,ts,cts,mts}',
      'astro.shared.mjs'
    ],
    languageOptions: {
      globals: globals.node
    }
  },
  eslintConfigPrettier
];
