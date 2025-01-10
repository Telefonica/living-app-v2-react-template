import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';

import { StbApp } from 'stb-app';

import { name } from '../package.json';

import './index.css';

const root = createRoot(document.getElementById('root') as HTMLElement);

window.laSdk
  .ready({ laName: name.replace('living-app-v2-', '') })
  .then(() => {
    root.render(
      <StrictMode>
        <StbApp />
      </StrictMode>,
    );

    window.addEventListener('laclose', () => {
      root.unmount();
    });
  })
  .catch((err) => {
    console.error('window.laSdk.ready(): ' + err);
  });
