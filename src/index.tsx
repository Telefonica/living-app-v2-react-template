import MhApp from 'mh-app';
import React from 'react';
import ReactDOM from 'react-dom/client';
import StbApp from 'stb-app';
import { name } from '../package.json';

import './index.css';

const root = ReactDOM.createRoot(document.getElementById('root') as HTMLElement);

const App = laSdk.channel === 'movistar-home' ? MhApp : StbApp;

window.laSdk
  .ready({ laName: name.replace('living-app-v2-', '') })
  .then(() => {
    root.render(
      <React.StrictMode>
        <App />
      </React.StrictMode>,
    );
  })
  .catch((err) => {
    console.error('window.laSdk.ready(): ' + err);
  });
