Js style guide:

- use functional components, functions and modules. do not use classes.
- do not use `this` keyword.
- use single quotes for strings.
- use `const` for functions and variables.
- prefer `export` to `export default`.
- use `import` for importing modules.
- use `import type { }` for importing types.
- use `import { } from './file'` for importing from local files.
- use `import { } from 'module'` for importing from node modules.

Ts style guide:

- prefer `type` for types. Do not use `interface`.
- do not use `enums` in typescript, use string literals like `'value' | 'anotherValue'`.
- do not use return type annotations for functions.
- use `React.ComponentProps<Component>` for getting component props type.
- do not import types from `react` package, use them directly as: `React.ReactNode`.

Css style guide:

- use CSS modules for styling.
- css files should be named `*.module.css`.
- import css files like this: `import styles from "./{file}.module.css"`.

Testing style guide:

- use jest for unit testing.
- testing files should be named `*.test.ts` or `*.test.tsx` if its a component.
- use `it` for test cases.
- use `describe` for grouping test cases.
- use `jest.mock()` for mocking modules.
- the first describe block should be the name of the symbol being tested,
  if its a component: "<ComponentName />"; if its a function: "functionName()"; if its and object: "objectName {}".
- use playwright for e2e testing.
- in jest, always use `screen.getByXX()` for querying elements.
- in jest, always prefer `screen.getByRole()` over `screen.getByTestId()`.
- in jest, testing a component, include first a test `it('renders: match snapshot', () => { ... })` to check if the component renders without crashing.
  using `component.toMatchSnapshot()`
- e2e testing files should be named `*.spec.ts`.
- e2e testing files should be placed in the `tests/integration` folder.
- e2e testing files follow this naming pattern: `{screenName}.{featureName}.spec.ts`; example: `home.navigation.spec.ts`.
- use playwright fixtures for reducing boilerplate code.
