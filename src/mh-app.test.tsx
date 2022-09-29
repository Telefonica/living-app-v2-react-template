import renderer from 'react-test-renderer';
import MhApp from './mh-app';

test('<MhApp /> renders correctly', () => {
  const render = renderer.create(<MhApp />).toJSON();
  expect(render).toMatchSnapshot();
});
