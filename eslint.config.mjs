import eslint from '@eslint/js';
import eslintConfigPrettier from 'eslint-config-prettier/flat';
import eslintPluginAstro from 'eslint-plugin-astro';
import eslintPluginSimpleImportSort from 'eslint-plugin-simple-import-sort';
import eslintPluginUnusedImports from 'eslint-plugin-unused-imports';
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
    files: ['**/*.{ts,astro}'],
    plugins: {
      'simple-import-sort': eslintPluginSimpleImportSort,
      'unused-imports': eslintPluginUnusedImports
    },
    rules: {
      '@typescript-eslint/no-unused-vars': 'off',
      'simple-import-sort/imports': 'error',
      'unused-imports/no-unused-imports': 'error',
      'unused-imports/no-unused-vars': 'error'
    }
  },
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
