import {AppProvider, EmptyState, Page} from '@shopify/polaris';
import enTranslations from '@shopify/polaris/locales/en.json';
import React from 'react';

import TestData from './TestData'

export default function App() {
  return (
    <AppProvider i18n={enTranslations}>
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
            url: 'https://help.shopify.com',
            external: true
          }}
          image="https://cdn.shopify.com/s/files/1/0757/9955/files/empty-state.svg"
        >
          <TestData />
        </EmptyState>
      </Page>
    </AppProvider>
  );
}
