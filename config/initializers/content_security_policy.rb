# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy
# For further information see the following documentation
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy

initial_frame_ancestors = [:https, "*.myshopify.com", "admin.shopify.com"]

def current_domain
  @current_domain ||= (params[:shop] && ShopifyApp::Utils.sanitize_shop_domain(params[:shop])) ||
    request.env["jwt.shopify_domain"] ||
    session[:shopify_domain]
end

frame_ancestors = lambda { [ current_domain, "admin.shopify.com" ] || initial_frame_ancestors }

Rails.application.config.content_security_policy do |policy|
  policy.default_src(:https, :self)
  policy.style_src(:https, "cdn.shopifycloud.com")
  policy.script_src(:https, "cdn.shopifycloud.com")
  policy.img_src(:self, :https, :data, "cdn.shopifycloud.com")
  policy.upgrade_insecure_requests(true)
  policy.frame_ancestors(frame_ancestors)
end

# If you are using UJS then enable automatic nonce generation
# Rails.application.config.content_security_policy_nonce_generator = -> request { SecureRandom.base64(16) }

# Set the nonce only to specific directives
# Rails.application.config.content_security_policy_nonce_directives = %w(script-src)

# Report CSP violations to a specified URI
# For further information see the following documentation:
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy-Report-Only
# Rails.application.config.content_security_policy_report_only = true