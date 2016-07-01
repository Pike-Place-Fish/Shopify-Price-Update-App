<%@Page Language="C#" EnableViewState="false" %>

<%@ Import Namespace="System.Configuration" %>
<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="System.Web.Configuration" %>

<%@ Import Namespace="RestSharp" %>
<%@ Import Namespace="RestSharp.Authenticators" %>

<%@ Import Namespace="Ignia.Shopify.PriceUpdateApp" %>
<%@ Import Namespace="Ignia.Shopify.PriceUpdateApp.Authentication" %>

<script RunAt="Server">

  /*============================================================================================================================
  | PRIVATE MEMBERS
  \---------------------------------------------------------------------------------------------------------------------------*/
    private     string          _apiKey                         = ConfigurationManager.AppSettings["ShopifyApiKey"];
    private     string          _clientSecret                   = ConfigurationManager.AppSettings["ShopifyClientSecret"];
    private     string          _shopifyStore                   = ConfigurationManager.AppSettings["ShopifyStore"];
    private     string          _shopifyHost                    = ".myshopify.com";

  /*============================================================================================================================
  | PAGE INIT
  \---------------------------------------------------------------------------------------------------------------------------*/
    void Page_Init(Object Src, EventArgs E) {

      // If access token is in querystring, user is authorized
      if (Request.QueryString["code"] != null) {

        // Set authentication data
        ShopifyAuthenticationData       authData                = new ShopifyAuthenticationData();
        authData.Code           = Request.QueryString["code"];
        authData.Hmac           = Request.QueryString["hmac"];
        authData.Shop           = Request.QueryString["shop"];
        authData.Timestamp      = Request.QueryString["timestamp"];

      }

      // Authorize user to communicate with the API, if not already authorized
      else {
        AuthorizeApi();
      }

    }

  /*============================================================================================================================
  | GET SHOPIFY HOST
  \---------------------------------------------------------------------------------------------------------------------------*/
    public string GetShopifyHost() {
      return Uri.UriSchemeHttps + Uri.SchemeDelimiter + _shopifyStore + _shopifyHost;
    }

  /*============================================================================================================================
  | EXECUTE (RESTSHARP REQUEST)
  \---------------------------------------------------------------------------------------------------------------------------*/
    // Endpoint: /admin/oauth/authorize
    // Params:
    // - client_id
    // - scope
    // - redirect_uri
    // - state

    /*
    public T Execute<T>(RestRequest request) where T : new() {

      Response.Write("Executing from wrapper<br/>");

      var client = new RestClient(GetShopifyHost());

      if (_apiKey != null) {
        client.Authenticator = new ShopifyAuthenticator(_apiKey);
      }

      var result = client.Execute<T>(request);

      if(result.StatusCode == System.Net.HttpStatusCode.Unauthorized) {
        //throw new Exception("Request was unauthorized");
        Response.Write("request was unauthorized");
      }

      if (result.ErrorException != null) {
        const string message = "Error retrieving response.  Check inner details for more information.";
      //throw new Exception(message, result.ErrorException);
        Response.Write("Response error: " + result.ErrorException);
      }

      return result.Data;
    }
    */

  /*============================================================================================================================
  | AUTHORIZE API
  \---------------------------------------------------------------------------------------------------------------------------*/
    private void AuthorizeApi() {

      string shopifyHost        = GetShopifyHost();
      string authorizeEndpoint  = "/admin/oauth/authorize";
      string authorizeUrl       = shopifyHost + "/admin/oauth/authorize";
      string stateStamp         = DateTime.UtcNow.ToString("yyyy-MM-dd HH:mm:ss.fff", CultureInfo.InvariantCulture);
      string scope              = "write_products,read_products";
      string redirectUri        = Uri.UriSchemeHttps + Uri.SchemeDelimiter + "PriceUpdateApp.Projects.Ignia.com/Authenticate";

      /*
      var client = new RestClient(GetHost());
      client.Authenticator = new HttpBasicAuthenticator(_apiKey, _clientSecret);

      RestRequest request = new RestRequest("/admin/oauth/authorize", Method.POST);

      request.AddQueryParameter("scope", scope);
      request.AddQueryParameter("redirect_uri", redirectUri);
      request.AddQueryParameter("state", stateStamp);

      request.AddHeader("Content-Type", "application/x-www-form-urlencoded");
      request.AddParameter("grant_type", "client_credentials");

      IRestResponse response = client.Execute(request);
      var content = response.Content;
      if(result.StatusCode == System.Net.HttpStatusCode.Unauthorized) {
        //throw new Exception("Request was unauthorized");
        Response.Write("request was unauthorized");
      }
      //OAuth2UriQueryParameterAuthenticator(string accessToken)
      //var response = Execute<ShopifyAuthenticationData>(request);

      Response.Write("response: " + ((content != null)? content.ToString() : "not available"));
      */

      Response.Redirect(
        shopifyHost             +
        authorizeEndpoint       +
        "?client_id=" + _apiKey +
        "&scope=" + scope       +
        "&redirect_uri=" + redirectUri
      );

    }

</script>

<!DOCTYPE html>
<html>
  <head>
    <title>Authenticate Shopify API</title>
  </head>
  <body>
  </body>
</html>