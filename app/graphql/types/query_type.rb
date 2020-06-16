require 'shopify_api'

module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false,
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
      shop = result.data.shop.name
      "Congratulations! Your requests to #{shop} are now authorized using Next-Gen Auth."
    end
  end
end
