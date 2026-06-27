import { defineConfig, globalIgnores } from 'eslint/config';
import nextVitals from 'eslint-config-next/core-web-vitals';

const eslintConfig = defineConfig([
  ...nextVitals,
  {
    // lint-staged invokes this config with cwd at the monorepo root
    // (see ../../.lintstagedrc), so the Next plugin can't auto-detect
    // the app directory unless told where it actually lives.
    settings: {
      next: {
        rootDir: 'apps/web/',
      },
    },
  },
  globalIgnores(['.next/**', 'out/**', 'build/**', 'next-env.d.ts']),
]);

export default eslintConfig;
