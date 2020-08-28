# frozen_string_literal: true
Rails.application.config.middleware.use(OmniAuth::Builder) do
# frozen_string_literal: true

provider :shopify,
  ShopifyApp.configuration.api_key,
  ShopifyApp.configuration.secret,
  scope: ShopifyApp.configuration.scope,
  setup: lambda { |env|
    strategy = env['omniauth.strategy']
    request = Rack::Request.new(env)

    shopify_auth_params = strategy.session['shopify.omniauth_params']&.with_indifferent_access
    shop_host = request.params['shop'] || (shopify_auth_params && shopify_auth_params['shop'])
    shop = if shop_host.present?
      "https://#{shop_host}"
    else
      ''
    end

    jwt = env['jwt.shopify_domain'] && env['jwt.shopify_user_id']

    strategy.options[:client_options][:site] = shop
    strategy.options[:old_client_secret] = ShopifyApp.configuration.old_secret
    strategy.options[:per_user_permissions] = strategy.session[:user_tokens] || jwt
    strategy.options[:provider_ignores_state] = jwt
  }
end
