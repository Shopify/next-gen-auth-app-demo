import axios from 'axios';
import { getSessionToken } from '@shopify/app-bridge-utils';

const instance = axios.create();

const interceptor = instance.interceptors.request.use(
  function (config) {
    return getSessionToken(window.app)
      .then((token) => {
        config.headers['Authorization'] = `Bearer ${token}`;
        return config;
      });
  }
);

export default instance;
