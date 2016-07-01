<%@Page Language="C#" EnableViewState="false" %>

<%@ Import Namespace="System.Configuration" %>
<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="System.Web.Configuration" %>

<%@ Import Namespace="RestSharp" %>
<%@ Import Namespace="RestSharp.Authenticators" %>

<%@ Import Namespace="Ignia.Shopify.PriceUpdateApp" %>
<%@ Import Namespace="Ignia.Shopify.PriceUpdateApp.Authentication" %>

<script RunAt="Server">

  /*===========================================================================================================================
  | PRIVATE MEMBERS
  \--------------------------------------------------------------------------------------------------------------------------*/
    private string _apiKey = ConfigurationManager.AppSettings["ShopifyApiKey"];
    private string _clientSecret = ConfigurationManager.AppSettings["ShopifyClientSecret"];
    private string _store = ConfigurationManager.AppSettings["ShopifyStore"];
    private string _shopifyHost = ".myshopify.com";

    // Base: Uri.UriSchemeHttps + Uri.SchemeDelimiter + _store + _shopifyHost
    // Endpoint: /admin/oauth/authorize
    // Params:
    // - client_id: bc523ca1610ad13903f53f1826b78b0d
    // - scope: write_products,read_products
    // - redirect_uri: http://PriceUpdateApp.projects.ignia.com
    // - state: need timestamp

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

  /*===========================================================================================================================
  | GET SHOPIFY HOST
  \--------------------------------------------------------------------------------------------------------------------------*/
    public string GetShopifyHost() {
      return Uri.UriSchemeHttps + Uri.SchemeDelimiter + _store + _shopifyHost;
    }

  /*===========================================================================================================================
  | PAGE INIT
  \--------------------------------------------------------------------------------------------------------------------------*/
  void Page_Init(Object Src, EventArgs E) {

    /*
    var client = new RestClient(GetHost());
    client.Authenticator = new HttpBasicAuthenticator(_apiKey, _clientSecret);

    RestRequest request = new RestRequest("/admin/oauth/authorize", Method.POST);

    request.AddQueryParameter("scope", "read_products,write_products");
    request.AddQueryParameter("redirect_uri", "http://priceupdateapp.projects.ignia.com");
    request.AddQueryParameter("state", "201606302337");

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

    string shopifyHost          = GetShopifyHost();
    string authorizeEndpoint    = "/admin/oauth/authorize";
    string authorizeUrl         = shopifyHost + "/admin/oauth/authorize";
    string stateStamp           = DateTime.UtcNow.ToString("yyyy-MM-dd HH:mm:ss.fff", CultureInfo.InvariantCulture);
    string scope                = "write_products,read_products";
    string redirectUri          = Uri.UriSchemeHttps + Uri.SchemeDelimiter + "PriceUpdateApp.Projects.Ignia.com";

    Response.Redirect(
      shopifyHost +
      authorizeEndpoint +
      "?client_id=" + _apiKey +
      "&scope=" + scope +
      "&redirect_uri=" + redirectUri
      );

  }

</script>

<!DOCTYPE html>
<html>
  <head>
    <title>RestSharp Test</title>
    <style type="text/css">
      body {
        font: 12px/18px Arial,sans-serif;
        }
    </style>
  </head>
  <body>

    <h3>Test RestSharp</h3>

    <p>

    </p>

  </body>
</html>