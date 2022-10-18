import { loadEnv } from "vite";

import react from "@vitejs/plugin-react";
import { createHtmlPlugin as html } from "vite-plugin-html";
import svgr from "vite-plugin-svgr";
import tsconfigPaths from "vite-tsconfig-paths";

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
    },
    build: {
      outDir: "build",
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
    ],
    base: "./",
  };
}

export default defineConfig;
