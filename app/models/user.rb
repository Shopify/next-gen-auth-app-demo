# frozen_string_literal: true
class User < ActiveRecord::Base
  include ShopifyApp::UserSessionStorage
  self.primary_key = 'shopify_user_id'
  has_many :sessions, foreign_key: "shopify_user_id"
  
  def api_version
    ShopifyApp.configuration.api_version
  end
end
