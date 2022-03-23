using System.Web;
using System.Web.Security;

namespace TestIteco.Models.Users
{
    public class AuthHelper
    {
        public static void SignOut()
        {
            HttpContext.Current.Session.Clear();

            FormsAuthentication.SignOut();
        }
    }
}