import React from "react";
import { AppProvider, Page, EmptyState } from "@shopify/polaris";
import { HttpLink } from "apollo-link-http";
import ApolloClient from "apollo-client";
import { ApolloProvider } from "@apollo/react-hooks";
import { createApp } from "@shopify/app-bridge";
import { authenticatedFetch, getSessionToken } from "@shopify/app-bridge-utils";
import { InMemoryCache } from "apollo-cache-inmemory";
import { gql } from "apollo-boost";
import { Query } from "react-apollo";

import { getEmbeddedAppProps } from "../utilities/";

export default function App() {
  const embeddedAppProps = getEmbeddedAppProps();
  const apiKey = getEmbeddedAppProps && embeddedAppProps.apiKey;
  const shopOrigin = getEmbeddedAppProps && embeddedAppProps.shopOrigin;

  const app = createApp({
    apiKey: apiKey,
    shopOrigin: shopOrigin,
    forceRedirect: true,
  });

  const client = new ApolloClient({
    link: new HttpLink({
      credentials: "same-origin",
      fetch: authenticatedFetch(app),
      uri: "/graphql",
    }),
    cache: new InMemoryCache(),
  });

  const TEST_QUERY = gql`
    query {
      testField
    }
  `;

  return (
    <AppProvider i18n={{}}>
      <ApolloProvider client={client}>
        <Page>
          <EmptyState
            heading="Manage your inventory transfers"
            action={{
              content: "Add transfer",
            }}
            secondaryAction={{
              content: "Learn more",
              url: "https://help.shopify.com",
            }}
            image="https://cdn.shopify.com/s/files/1/0757/9955/files/empty-state.svg"
          >
            <Query query={TEST_QUERY}>
              {({ loading, error, data }) => {
                console.log(loading, error, data);
                if (loading) return <div> Fetching.. </div>;
                if (error) return <div> Error! </div>;
                return <div> {data.testField} </div>;
              }}
            </Query>
            <p> Track and receive your incoming inventory from suppliers. </p>
          </EmptyState>
        </Page>
      </ApolloProvider>
    </AppProvider>
  );
}
