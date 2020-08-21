# App Bridge Authentication

> __Note:__ This is a public beta feature.

A basic Rails/React demo app created to showcase [App Bridge Authentication][1].

## Contents

- [Quick Start](#quick-start)
- [Creating a JWT-authenticated Shopify App](#creating-a-jwt-authenticated-shopify-app)
    - [Creating a backend using Rails](#creating-a-backend-using-rails)
    - [Creating a frontend using React](#creating-a-frontend-using-react)
    - [Making authenticated requests using App Bridge](#making-authenticated-requests-using-app-bridge)
        - [Changes needed on the backend](#changes-needed-on-the-backend)
        - [Changes needed on the frontend](#changes-needed-on-the-frontend)

## Quick Start

To run this app locally, you can clone this repository and do the following.

1. Create a `.env` file to specify your `Shopify API Key` and `Shopify API Secret` available from your partners dashboard.

```
SHOPIFY_API_KEY='YOUR API KEY FROM SHOPIFY PARTNERS DASHBOARD'
SHOPIFY_API_SECRET_KEY='YOUR API SECRET KEY FROM SHOPIFY PARTNERS DASHBOARD'
```

> __Note:__ If you do not have a Shopify API Key or Shopify API Secret, see the following sections of the [Build a Shopify App with Node and React][2] guide:
> 1. [Expose your dev environment][3]
> 2. [Get a Shopify API Key and Shopify API secret key][4]
> 3. [Add the Shopify API Key and Shopify API secret key][5]

2. Run the following to install the required dependencies.

```console
$ bundle install
$ yarn install
$ rails db:migrate
```

3. Ensure ngrok is running on port `3000`.

```console
$ngrok http 3000
```

> __Note:__ This port number is arbitrary - you may choose to specify the port number you plan to listen to this app on.

4. Run the following to start the app.

```console
$ rails s
```

5. Install this app on your shop as normal and open it in Admin. Requests to protected resources like the `GraphqlController` should now be secured with an `Authorization: Bearer <session token> header. 

![App dashboard][s1]

_**Above:** Example text received from a protected `/graphql` endpoint_

![App requests][s2]

_**Above:** Requests made to the protected `/graphql` endpoint are automatically
authorized using a JWT token_


## Creating a JWT-authenticated Shopify App

This guide uses Rails 6 to build a React-enabled Rails app using webpacker. This app's requests to its backend are protected using App Bridge Authentication session tokens. Follow the guide below to get started.

### Creating a backend using Rails

1. Run the following in your working directory.

```console
$ rails new <your-app-name> --webpack=react
```

2. In your newly create app, open the Gemfile and add the following dependencies.

```rb
gem 'dotenv-rails'
gem 'graphql'
gem 'react-rails'
gem 'shopify_app'    # '~> 14.0.0' is used for this demo app
```

3. Run the following to install these gems.

```console
$ bundle install
```

4. Run the following generator to generate an embedded app using the Shopify App gem.

```console
$ rails generate shopify_app --with-session-token
```

* The `--with-session-token` flag ensures that this app uses App Bridge Authentication session tokens right out of the box. This flag is available in [Shopify App gem version `>=14.0.0`][6].
* This command generates the following:
    * An `AuthenticatedController` used to protect resources with session tokens
    * A default `ProductsController` that inherits from `AuthenticatedController`
    * A `HomeController` with a view that leverages App Bridge Authentication to fetch products from `ProductsController` using a session token

5. Run the following installer to create a GraphQL backend.

```console
$ rails generate graphql:install
```

6. Run any outstanding db migrations.

```console
$ rails db:migrate
```

### Creating a frontend using React

1. In the root folder of your app, run the following installers to ensure your app is React-enabled via webpack.

```console
$ rails webpacker:install
$ rails webpacker:install:react
$ rails generate react:install
```

2. Add the following dependencies to your `package.json` file.

```console
$ yarn add \
     @apollo/client \
     graphql \
     @shopify/app-bridge-utils@1.26.0 \
     @shopify/polaris \
```

* Session token utility methods are available to [App Bridge in release `v1.22.0`][7] or later of  `@shopify/app-bridge-utils`.

3. Generate a default `App.js` component.

```console
$ rails generate react:component App
```

4. Overwrite `app/views/home/index.html.erb` to match the following.

```erb
<!DOCTYPE html>
<html lang="en">
  <head>
    <link rel="stylesheet" href="https://unpkg.com/@shopify/polaris@4.22.0/styles.min.css"/>
  </head>
  <body>
    <%= react_component("App") %>
  </body>
</html>
```

### Making authenticated requests using App Bridge

#### Changes needed on the backend

1. Make `GraphqlController` in `/app/controllers/graphql_controller.rb` inherit `AuthenticatedController`.

```rb
class GraphqlController < AuthenticatedController
  ...
```

* This makes your `GraphqlController` an authenticated resource. To access this endpoint, a session token is required on all requests.

2. Add an expected message to the `test_field` method of `app/grapqhl/types/query_type.rb`.

```rb
def test_field
  "Congratulations! Your requests are now authorized using App Bridge Authentication."
end
```

#### Changes needed on the frontend

1. In `app/javascript/components/App.js`, import `authenticatedFetch` from `@shopify/app-bridge-utils`.

```javascript
import { authenticatedFetch } from '@shopify/app-bridge-utils';
```

* `authenticatedFetch()` appends an `Authorization: Bearer <session token>` header to all of the requests made by this Apollo Client.
* Tokens are automatically cached and updated as needed by this method.
* This method takes an App Bridge instance as an argument. An instance is provided to all embedded apps via `app/javascript/shopify_app/shopify_app.js`.

2. In the same file, create an Apollo Client and provide `authenticatedFetch` as the fetch method.

```javascript
import {
  ApolloClient,
  ApolloProvider,
  HttpLink,
  InMemoryCache,
} from '@apollo/client';
import { AppProvider, EmptyState, Page } from '@shopify/polaris';
import { authenticatedFetch } from '@shopify/app-bridge-utils';

import enTranslations from '@shopify/polaris/locales/en.json';
import React from 'react';

export default function App() {
  const client = new ApolloClient({
    link: new HttpLink({
      credentials: 'same-origin',
      fetch: authenticatedFetch(window.app), // created in shopify_app.js
      uri: '/graphql'
    }),
    cache: new InMemoryCache()
  });

  return (
    <AppProvider i18n={enTranslations}>
      <ApolloProvider client={client}>
        <Page>
          <EmptyState>
            ...
          </EmptyState>
        </Page>
      </ApolloProvider>
    </AppProvider>
  );
}
```

3. Create a `TestData` component to query the `/graphql` endpoint of this app.

```javascript
import { gql, useQuery } from '@apollo/client';

import React from 'react';

const TEST_QUERY = gql`query { testField }`;

export default function TestData() {
  const {loading, error, data} = useQuery(TEST_QUERY);

  if (loading) {
    return (
      <div>Loading</div>
    );
  } else if (error) {
    return (
      <div>Something went wrong!</div>
    );
  } else {
    return (
      <p>{data.testField}</p>
    );
  }
}
```

4. Import the `TestData` in the `App` component.

```javascript
...

import TestData from './TestData'

export default function App() {

 ...

 return (
    <AppProvider i18n={enTranslations}>
      <ApolloProvider client={client}>
        <Page>
          <EmptyState>
            <TestData/>    # Add the TestData component here
          </EmptyState>
        </Page>
      </ApolloProvider>
    </AppProvider>
  );
}
```

5. Requests made to `/graphql` should now be authenticated with an `Authorization: Bearer <session-token>` header.

[//]: # "Links"
[s1]: ./app/assets/images/screenshot-1.png
[s2]: ./app/assets/images/screenshot-2.png
[1]: https://shopify.dev/tools/app-bridge/authentication
[2]: https://shopify.dev/tutorials/build-a-shopify-app-with-node-and-react/embed-your-app-in-shopify#get-a-shopify-api-key
[3]: https://shopify.dev/tutorials/build-a-shopify-app-with-node-and-react/embed-your-app-in-shopify#expose-your-dev-environment
[4]: https://shopify.dev/tutorials/build-a-shopify-app-with-node-and-react
[5]: https://shopify.dev/tutorials/build-a-shopify-app-with-node-and-react/embed-your-app-in-shopify#add-the-shopify-api-key
[6]: https://github.com/Shopify/shopify_app/releases/tag/v14.0.0
[7]: https://www.npmjs.com/package/@shopify/app-bridge/v/1.22.0
