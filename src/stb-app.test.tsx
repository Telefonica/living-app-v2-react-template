import renderer from 'react-test-renderer';
import StbApp from './stb-app';

test('<StbApp /> renders correctly', () => {
  const render = renderer.create(<StbApp />).toJSON();
  expect(render).toMatchSnapshot();
});
