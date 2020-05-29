import { AppConfig } from "@shopify/app-bridge";

export function getRootElement() {
  const rootElement = document.getElementById("app");
  if (!rootElement) {
    return null;
  }

  return rootElement;
}

export function getShopOrigin() {
  const rootElement = getRootElement();
  if (!rootElement) {
    return null;
  }

  const shopOrigin = rootElement.dataset.shopOrigin;
  if (!shopOrigin) {
    return null;
  }

  return shopOrigin;
}

export function getEmbeddedAppProps() {
  const rootElement = getRootElement();

  if (!rootElement) {
    return {};
  }

  const apiKey = rootElement.dataset.apiKey;
  const shopOrigin = rootElement.dataset.shopOrigin;

  if (!apiKey || !shopOrigin) {
    const message = [];

    if (!apiKey) {
      message.push("apiKey is null");
    }

    if (!shopOrigin) {
      message.push("shopOrigin is null");
    }

    throw new Error(message.join(", "));
  }

  return {
    apiKey,
    shopOrigin,
  };
}
