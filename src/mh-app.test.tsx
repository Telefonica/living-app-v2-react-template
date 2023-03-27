import { render } from '@testing-library/react';
import MhApp from './mh-app';

describe('<MhApp />', () => {
  it('render: match snapshot', () => {
    const { asFragment } = render(<MhApp />);
    expect(asFragment()).toMatchSnapshot();
  });
});
