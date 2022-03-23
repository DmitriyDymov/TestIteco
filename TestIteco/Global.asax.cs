using System;
using System.Web;
using System.Web.Routing;
using System.Web.Security;

namespace TestIteco
{

    public class Global_asax : System.Web.HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            DevExpress.Web.ASPxWebControl.CallbackError += new EventHandler(Application_Error);

            var routes = Routes.Route.GetRoutes();

            foreach (var r in routes)
            {
                RouteTable.Routes.MapPageRoute(r.RouteID, r.RouteURL, r.RouteFile);
            }
        }

        void Application_End(object sender, EventArgs e)
        {
            // Code that runs on application shutdown
        }

        void Application_Error(object sender, EventArgs e)
        {
            // Code that runs when an unhandled error occurs
        }

        void Session_Start(object sender, EventArgs e)
        {
            if (!Request.IsAuthenticated || this.Session["UserID"] != null) return;

            var userID = HttpContext.Current.User.Identity.Name;

            if (!string.IsNullOrEmpty(userID))
            {
                Session["UserID"] = userID;
            }
            else
            {
                FormsAuthentication.SignOut();
            }
        }

        void Session_End(object sender, EventArgs e)
        {

        }
    }
}