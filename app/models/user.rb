# frozen_string_literal: true
class User < ActiveRecord::Base
  include ShopifyApp::UserSessionStorage

  # Override access_scopes= to specify how access scopes are saved
  def access_scopes=(scopes)
    super(scopes)
  end

  # Override access_scopes to specify where access scopes are stored
  def access_scopes
    super
  end

  def api_version
    ShopifyApp.configuration.api_version
  end
end
