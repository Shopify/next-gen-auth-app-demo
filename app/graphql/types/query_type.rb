require 'shopify_api'

module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, ExampleResponse, null: false,
      description: "An example field added by the generator"
    def test_field
      client = ShopifyAPI::GraphQL.client

      shop_name_query = client.parse <<-'GRAPHQL'
        {
          shop {
            name
          }
        }
      GRAPHQL

      result = client.query(shop_name_query)

      return {errors: result.errors.messages['data']} if result.errors.messages['data'].eql?(["401 Unauthorized"])

      shop = result.data.shop.name
      {test_field: "Congratulations! Your requests to #{shop} are now authenticated using App Bridge Authentication."}
    end
  end
end
