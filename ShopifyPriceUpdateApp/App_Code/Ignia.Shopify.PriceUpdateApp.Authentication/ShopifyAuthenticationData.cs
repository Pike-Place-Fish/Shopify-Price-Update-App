using System;

namespace Ignia.Shopify.PriceUpdateApp.Authentication {

  /*============================================================================================================================
  | CLASS: SHOPIFY AUTHENTICATON DATA
  \---------------------------------------------------------------------------------------------------------------------------*/
  /// <summary>
  ///   Container object for authentication properties returned as part of the Shopify OAuth authentication response.
  /// </summary>
  public class ShopifyAuthenticationData {

    /// <summary>
    ///   The authorization code with which to make authenticated Shopify requests.
    /// </summary>
    public string Code {
      get; set;
    }

    /// <summary>
    ///   The hash-based authorization code passed through the authentication response; must be validated.
    /// </summary>
    public string Hmac {
      get; set;
    }

    /// <summary>
    ///   The fully-qualified Shopify shop subdomain.
    /// </summary>
    public string Shop {
      get; set;
    }

    /// <summary>
    ///   The unique identifier sent with the request; used to validate the response.
    /// </summary>
    public string State {
      get; set;
    }

    /// <summary>
    ///   Timestamp sent with the request response; used for response verification.
    /// </summary>
    public string Timestamp {
      get; set;
    }

  }

}
