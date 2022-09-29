import '@testing-library/jest-dom';

beforeEach(() => {
  const localStorageMock = {
    getItem: jest.fn(),
    setItem: jest.fn(),
    clear: jest.fn(),
  };

  // @ts-expect-error is ok
  window.localStorage = localStorageMock;
});
