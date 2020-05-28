# Next-Gen-Auth

> [App Demo]

1. `rails new <your app>`
2. Add `.env` to your `.gitignore` file
3. Add the following gems to your `Gemfile`:

```
gem 'shopify_app'
gem 'graphql'
gem 'react-rails'
gem 'graphiql-rails', group: :development
gem 'dotenv-rails'
```

4. [Register your app on Partners][1]

5. Create a `.env` file in your root:

You can find these in your Partners Dashboard (follow these steps to register your app).

```
SHOPIFY_API_KEY=<your Shopify API key>
SHOPIFY_API_SECRET=<your Shopify API secret>
```

6. Generate your Shopify App:

- `rails generate shopify_app`
- `bin/rails db:migrate`

7. Enable the beta `app_session_token` on your app using Services Internal

8. Run `rails generate graphql:install`

[//]: # "Links"
[1]: https://development.shopify.io/engineering/developing_at_Shopify/apps/first-party_apps/create_and_install_an_app_locally#Register_your_app_with_a_Shopify_Partners_account
