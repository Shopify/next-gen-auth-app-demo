# frozen_string_literal: true
class Session < ActiveRecord::Base
  include ShopifyApp::ActualSessionStorage
  self.primary_key = 'shopify_user_id'
  has_one :user, foreign_key: "shopify_user_id"
  
  def api_version
    ShopifyApp.configuration.api_version
  end
end