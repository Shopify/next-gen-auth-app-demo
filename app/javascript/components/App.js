import {
  ApolloClient,
  ApolloProvider,
  HttpLink,
  InMemoryCache,
} from '@apollo/client';
import { AppProvider, EmptyState, Page } from '@shopify/polaris';
import { userAuthorizedFetch } from '@shopify/app-bridge-utils';
import { authenticatedFetch } from '@shopify/app-bridge-utils/utilities/session-token/authenticated-fetch';

import enTranslations from '@shopify/polaris/locales/en.json';
import React from 'react';

import TestData from './TestData'

export default function App() {
  const client = new ApolloClient({
    link: new HttpLink({
      credentials: 'same-origin',
      fetch: userAuthorizedFetch({app: window.app, fetchOperation: authenticatedFetch(window.app)}),
      uri: '/graphql'
    }),
    cache: new InMemoryCache()
  });

  return (
    <AppProvider i18n={enTranslations}>
      <ApolloProvider client={client}>
        <Page>
          <EmptyState
            heading='Say goodbye to third-party cookies'
            action={{
              content: 'GitHub repo',
              url: 'https://github.com/Shopify/next-gen-auth-app-demo',
              external: true
            }}
            secondaryAction={{
              content: 'Learn more',
              url: 'https://shopify.dev/tools/app-bridge/authentication',
              external: true
            }}
            image='https://cdn.shopify.com/s/files/1/0757/9955/files/empty-state.svg'
          >
            <TestData />
          </EmptyState>
        </Page>
      </ApolloProvider>
    </AppProvider>
  );
}
