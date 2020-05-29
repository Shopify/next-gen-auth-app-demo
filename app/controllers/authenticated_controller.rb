# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  include ShopifyApp::Authenticated

  skip_before_action :verify_authenticity_token

  private

  def valid_jwt_header?
    jwt_shopify_domain.present?
  end
end
