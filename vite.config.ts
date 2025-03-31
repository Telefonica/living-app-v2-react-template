import { loadEnv } from 'vite';

/* Plugins */
import react from '@vitejs/plugin-react-swc';
import { createHtmlPlugin as html } from 'vite-plugin-html';
import svgr from 'vite-plugin-svgr';
import tsconfigPaths from 'vite-tsconfig-paths';
import legacy from '@vitejs/plugin-legacy';

/**
 * @see https://vitejs.dev/config/
 */
function defineConfig({ mode }) {
  // Load app-level env vars to node-level env vars.
  // @see https://stackoverflow.com/questions/70709987
  const env = {
    ...loadEnv(mode, process.cwd()),
    ...process.env,
  };

  return {
    server: {
      port: 3000,
      watch : {
        ignored: ['**/.venv/**']
      }
    },
    build: {
      outDir: 'build',
    },
    plugins: [
      react(),
      svgr(),
      html({
        minify: true,
        inject: {
          data: { ...env }, // XXX
        },
      }),
      tsconfigPaths(),
      // Plugin to maintain compatibility with browsers < Safari v14
      legacy({
        // For add polyfills, see https://github.com/vitejs/vite/tree/main/packages/plugin-legacy#polyfill-specifiers
        // polyfills: ['es.array.flat', 'es.array.flat-map'],
        targets: ['safari 10'],
      }),
    ],
    base: './',
  };
}

export default defineConfig;
