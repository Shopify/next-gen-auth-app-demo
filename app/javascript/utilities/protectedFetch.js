import {authenticatedFetch} from '@shopify/app-bridge-utils';
import {AuthCode} from '@shopify/app-bridge/actions';

function getAuthCode(appBridge) {
  return new Promise((resolve, reject) => {
    const unsubscribe = appBridge.subscribe(AuthCode.ActionType.RESPOND, (payload) => {
      if (payload) {
        resolve(payload);
      } else {
        reject("Failed to load");
      }
      unsubscribe();
    });

    appBridge.dispatch(AuthCode.request());
  });
}

function invalidUserAccessTokenError(responseObject) {
  return responseObject.headers.get("X-Shopify-Request-Auth-Code");
}

export default function protectedFetch(appBridge) {
  const jwtFetch = authenticatedFetch(appBridge);

  return async (uri, options) => {
    const response = await jwtFetch(uri, options);
    if (invalidUserAccessTokenError(response)) {
      const { code, hmac, shop, timestamp } = await getAuthCode(appBridge);
      const callback_uri = `auth/shopify/callback?code=${code}&hmac=${hmac}&shop=${shop}&timestamp=${timestamp}`

      const callback_response = await jwtFetch(callback_uri);
      if (callback_response.status == 200) {
        return jwtFetch(uri, options);
      }
    } else {
      return response;
    }
  };
}
