import { render } from '@testing-library/react';
import StbApp from './stb-app';

describe('<StbApp />', () => {
  beforeEach(() => {
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    (window as any).laSdk = {
      // TODO: LIVING-APP SDK TEAM
      // expose a mocking library for laSdk + Jest
      // we'll notify you as soon as this is available
      focus: jest.fn(),
      createSuggestions: jest.fn(),
      video: {
        start: jest.fn(),
        stop: jest.fn(),
      },
    };
  });

  test('render: match snapshot', () => {
    const { asFragment } = render(<StbApp />);
    expect(asFragment()).toMatchSnapshot();
  });
});
