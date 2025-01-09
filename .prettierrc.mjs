import fs from 'fs/promises';
import yaml from 'js-yaml';

const prettierFile = await fs.readFile('./node_modules/@telefonica/living-apps-eslint-config/.prettierrc', 'utf8');

const prettierConfig = yaml.load(prettierFile);

export default prettierConfig;