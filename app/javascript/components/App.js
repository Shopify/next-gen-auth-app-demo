import { AppProvider, EmptyState, Page } from '@shopify/polaris';
import ApolloClient from 'apollo-client';
import { ApolloProvider } from '@apollo/react-hooks';
import { authenticatedFetch } from '@shopify/app-bridge-utils';
import enTranslations from '@shopify/polaris/locales/en.json';
import { gql } from 'apollo-boost';
import { HttpLink } from 'apollo-link-http';
import { InMemoryCache } from 'apollo-cache-inmemory';
import { Query } from 'react-apollo';
import React from 'react';

class App extends React.Component {
  render () {
    const client = new ApolloClient({
      link: new HttpLink({
        credentials: 'same-origin',
        fetch: authenticatedFetch(window.app), // created in shopify_app.js
        uri: '/graphql'
      }),
      cache: new InMemoryCache()
    });

    const TEST_QUERY = gql`query { testField }`;

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
                url: 'https://help.shopify.com',
                external: true
              }}
              image="https://cdn.shopify.com/s/files/1/0757/9955/files/empty-state.svg"
            >
              <Query query={TEST_QUERY}>
                {({ loading, error, data }) => {
                  if (loading) return <div> Loading.. </div>;
                  if (error) return <div> Something went wrong! </div>;
                  return <p> {data.testField} </p>;
                }}
              </Query>
            </EmptyState>
          </Page>
        </ApolloProvider>
      </AppProvider>
    );
  }
}
export default App;
