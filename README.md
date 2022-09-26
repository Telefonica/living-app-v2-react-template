<p align="right">
  <img src="https://flat.badgen.net/badge/LivingApps/%20v2.0/pink"/>
</p>

# Getting Started with Living Apps 2.0

This template project was forked from [living-app-v2-react-template](https://github.com/Telefonica/living-app-v2-react-template)

## Available Scripts 🚀

In the project directory, you can run:

### `npm start`

Runs the app in the development mode.\
Open [http://localhost:3000](http://localhost:3000) to view it in the browser.

The page will reload if you make edits.\
You will also see any lint errors in the console.

### `npm test`

Launches the test runner in the interactive watch mode.

### `npm run build`

Builds the app for production to the `build` folder.\
It correctly bundles React in production mode and optimizes the build for the best performance.

### `npm run lint`

Runs the linter

### `npm run prettier:check` & `npm run prettier:write`

Runs the code formatter (check mode or fixing mode)

### `npm run blue-ball`

Shortcut for a complete [blue-ball](https://www.jenkins.io/blog/2012/03/13/why-does-jenkins-have-blue-balls/) building check: linter + formatter + tests + build + package

## Learn More 📚

[DEV DOCS]('https://la-docs.apps.ocp-epg.tid.es/docs/intro/')

## Development Stack 🥞

This [React](https://reactjs.org/) app uses this development stack:

|                                               | Desc.                                                            | Configured by                      | Dev Dependencies                                                                                                                                                                                                                             |
| :-------------------------------------------- | ---------------------------------------------------------------- | ---------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Vite](https://vitejs.dev/)                   | Development environment (dev server) with Hot Module Replacement | [`vite.config.ts`](vite.config.ts) | <ul><li>`vite`</li><li>`@vitejs/plugin-react`</li><li>`vite-plugin-html`</li><li>`vite-plugin-svgr`</li><li>`vite-tsconfig-paths`</li></ul>                                                                                                  |
| [rollup](https://rollupjs.org/guide/en/)      | Module bundler (used by Vite)                                    | [`vite.config.ts`](vite.config.ts) | .                                                                                                                                                                                                                                            |
| [TypeScript](https://www.typescriptlang.org/) | Strongly typed programming language that builds on JavaScript    | [tsconfig.json](tsconfig.json)     | <ul><li>`typescript`</li><li>`@types/living-apps-core-web`</li><li>`@types/react`</li><li>`@types/...`</li><li>`@typescript-eslint/eslint-plugin`</li><li>`@typescript-eslint/parser`</li></ul>                                              |
| [JEST](https://jestjs.io/)                    | Testing Framework                                                | [`jest.config.js`](jest.config.js) | <ul><li>`jest`</li><li>`@testing-library/react`</li><li>`@testing-library/jest-dom`</li><li>`jest-environment-jsdom`</li><li>`jest-transform-stup`</li><li>`react-test-renderer`</li><li>`identity-object-proxy`</li><li>`ts-jest`</li></ul> |
| [`ESLint`](https://eslint.org/)               | js static analyzer                                               | [.eslintrc.yaml](.eslintrc.yaml)   | <ul><li>`eslint`</li><li>`eslint-config-prettier`</li><li>`eslint-plugin-prettier`</li><li>`eslint-plugin-react`</li><li>`eslint-plugin-react-hooks`</li></ul>                                                                               |
| [Prettier](https://prettier.io/)              | Opinionated code formatter                                       | [.prettierrc](.prettierrc)         | <ul><li>`prettier`</li></ul>                                                                                                                                                                                                                 |
