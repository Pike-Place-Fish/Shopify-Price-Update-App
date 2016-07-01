<%@ Page Language="C#" %>

<Script RunAt="Server">

/*==============================================================================================================================
| PAGE INIT
\-----------------------------------------------------------------------------------------------------------------------------*/
  void Page_Init(Object Src, EventArgs E) {

    //Redirect to Authentication
    Response.Redirect("/Authenticate/");

  }

</Script>