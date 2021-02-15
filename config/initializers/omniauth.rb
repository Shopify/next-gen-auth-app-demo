# frozen_string_literal: true

Rails.application.config.middleware.use(OmniAuth::Builder) do
  provider :shopify,
           ShopifyApp::OmniAuthConfiguration.api_key,
           ShopifyApp::OmniAuthConfiguration.secret,
           scope: ShopifyApp.configuration.scope,
           setup: lambda { |env|
              configuration = ShopifyApp::OmniAuthConfiguration.new(env['omniauth.strategy'], Rack::Request.new(env))
              configuration.build_options
           }
end
