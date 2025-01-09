import { useEffect } from 'react';

import image from 'assets/image.png';

import type { JSX } from 'react';

import './stb-app.css';

export const StbApp = (): JSX.Element => {
  useEffect(() => {
    laSdk.createSuggestions([
      {
        text: 'Check Docs',
        up: 'center-elem',
        onClick: () => {
          window.open('https://la-docs.apps.ocp-epg.tid.es/docs/intro/', '_blanck');
        },
      },
      {
        text: 'Show Toast',
        up: 'center-elem',
        onClick: () => {
          laSdk.createToast({ type: 'success', text: 'Hello there!' });
        },
      },
    ]);
  }, []);

  return (
    <div className='stb-app'>
      <img src={image} className='stb-app__image' />
      <div className='stb-app__text la-navigable' id='center-elem' data-down='la-suggestions'>
        Edit <code>src/stb-app.tsx</code>.
      </div>
    </div>
  );
};
