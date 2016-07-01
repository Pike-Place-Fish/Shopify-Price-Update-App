using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using RestSharp;
using RestSharp.Authenticators;

namespace Ignia.Shopify.PriceUpdateApp {

  /*============================================================================================================================
  | CLASS: SHOPIFY AUTHENTICATOR
  \---------------------------------------------------------------------------------------------------------------------------*/
  /// <summary>
  ///   Extends the global <see cref="Startup" /> class by providing methods it can use to configure authorization.
  /// </summary>
  ///  <param name="accessToken">The Shopify application's access token (API key).</param>
  public class ShopifyAuthenticator : OAuth2Authenticator {
    public ShopifyAuthenticator(string accessToken) : base(accessToken) {
    }

    /*==========================================================================================================================
    | AUTHENTICATE
    \-------------------------------------------------------------------------------------------------------------------------*/
    /// <summary>
    ///   Override for RestSharp's <see 
    ///   cref="RestSharp.Authenticators.OAuth2Authenticator.Authenticate(IRestClient, IRestRequest)" />
    ///   method; adds Shopify's Access Token header to the authorization request, if it has not already been added.
    /// </summary>
    /// <param name="client">The REST client object.</param>
    /// <param name="request">The REST request.</param>
    public override void Authenticate(IRestClient client, IRestRequest request) {
      if (!request.Parameters.Any(p => p.Name.Equals("X-Shopify-Access-Token", StringComparison.OrdinalIgnoreCase))) {
        request.AddParameter("X-Shopify-Access-Token", AccessToken, ParameterType.HttpHeader);
      }
    }

  }
}
