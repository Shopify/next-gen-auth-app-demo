# App Bridge Authentication

A demo app created using Rails, React, and App Bridge for the Shopify tutorial [Build a Shopify app with Rails, React, and App Bridge](https://shopify.dev/tutorials/build-rails-react-app-that-uses-app-bridge-authentication).

## Quick Start

To run this app locally, you can clone this repository and do the following.

1. Create a `.env` file to specify this app's `API key` and `API secret key` app credentials that can be found in the Shopify Partners dashboard.

```
SHOPIFY_API_KEY=<The API key app credential specified in the Shopify Partners dashboard>
SHOPIFY_API_SECRET=<The API secret key app credential specified in the Shopify Partners dashboard>
APP_URL=<The app URL specified in the Shopify Partners dashboard>
```


> __Note:__ If you do not have an API key or an API secret key, see the following sections of the [Build a Shopify App with Node and React](https://shopify.dev/tutorials/build-a-shopify-app-with-node-and-react/embed-your-app-in-shopify#get-a-shopify-api-key) guide.
>
>> **Important**: This guide names its API secret key environment variable `SHOPIFY_API_SECRET_KEY` rather than `SHOPIFY_API_SECRET`. The Shopify App gem uses the latter.
>
> 1. [Expose your dev environment](https://shopify.dev/tutorials/build-a-shopify-app-with-node-and-react/embed-your-app-in-shopify#expose-your-dev-environment)
> 2. [Get a Shopify API Key and Shopify API secret key](https://shopify.dev/tutorials/build-a-shopify-app-with-node-and-react/embed-your-app-in-shopify#get-a-shopify-api-key)
> 3. [Add the Shopify API Key and Shopify API secret key](https://shopify.dev/tutorials/build-a-shopify-app-with-node-and-react/embed-your-app-in-shopify#add-the-shopify-api-key)

2. Run the following to install the required dependencies.

```console
$ bundle install
$ yarn install
$ rails db:migrate
```

3. Ensure ngrok is running on port `3000`.

```console
$ ngrok http 3000
```

> __Note:__ This port number is arbitrary - you may choose to specify the port number you plan to listen to this app on.

4. Run the following to start the app.

```console
$ rails s
```

5. Install and open this app on a shop. Requests to authenticated resources, like the `GraphqlController`, should now be secured with an `Authorization: Bearer <session token>` header. 

![App dashboard][s1]

_**Above:** Example text received from a protected `/graphql` endpoint_

![App requests][s2]

_**Above:** Requests made to the protected `/graphql` endpoint are automatically
authorized using a JWT token_

[//]: # "Links"
[s1]: ./app/assets/images/screenshot-1.png
[s2]: ./app/assets/images/screenshot-2.png