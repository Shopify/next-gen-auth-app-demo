# App Bridge Authentication

> __Note:__ This project uses resources that are currently in a public beta

A demo app created using Rails, React, and App Bridge for the Shopify tutorial [Build a Shopify app with Rails, React, and App Bridge][1].

## Quick Start

To run this app locally, you can clone this repository and do the following.

1. Create a `.env` file to specify your `Shopify API Key` and `Shopify API Secret` available from your partners dashboard.

```
SHOPIFY_API_KEY='YOUR API KEY FROM SHOPIFY PARTNERS DASHBOARD'
SHOPIFY_API_SECRET='YOUR API SECRET KEY FROM SHOPIFY PARTNERS DASHBOARD'
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
$ ngrok http 3000
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

[//]: # "Links"
[s1]: ./app/assets/images/screenshot-1.png
[s2]: ./app/assets/images/screenshot-2.png
[1]: https://shopify.dev/tutorials/build-rails-react-app-that-uses-app-bridge-authentication
[2]: https://shopify.dev/tutorials/build-a-shopify-app-with-node-and-react/embed-your-app-in-shopify#get-a-shopify-api-key
[3]: https://shopify.dev/tutorials/build-a-shopify-app-with-node-and-react/embed-your-app-in-shopify#expose-your-dev-environment
[4]: https://shopify.dev/tutorials/build-a-shopify-app-with-node-and-react
[5]: https://shopify.dev/tutorials/build-a-shopify-app-with-node-and-react/embed-your-app-in-shopify#add-the-shopify-api-key
