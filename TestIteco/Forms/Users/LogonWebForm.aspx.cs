using System;
using System.Web.Security;
using DevExpress.Web;

namespace TestIteco.Forms.Users
{
    public partial class LogonWebForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void LogonCallback_OnCallback(object source, CallbackEventArgs e)
        {
            var p = e.Parameter.Split('|');
            var email = p[0];
            var password = p[1];

            var normalEmail = email.Replace(" ", "").ToLower();
            var normalPassword = password.Replace(" ", "");

            if (normalEmail == "global@it.com" && normalPassword == "exists")
            {
                FormsAuthentication.SetAuthCookie(Convert.ToString(Session["UserID"]), false);
                e.Result = "2";
            }
            else
            {
                e.Result = "Указаны неверные логин или пароль";
            }

            //var users = Users.UserLogon.GetUsers().Where(r => r.UserEnabled == true);
            //var exists = false;

            //foreach (var user in users)
            //{
            //    if (string.IsNullOrEmpty(user.UserPassword))
            //        continue;

            //    if (!string.Equals(user.UserEmail, normalEmail, StringComparison.CurrentCultureIgnoreCase) ||
            //        user.UserPassword != normalPassword) continue;

            //    DeviceLog.SaveLog();
            //    Session["UserID"] = user.UserID;

            //    exists = true;
            //    break;
            //}

            //if (exists)
            //{
            //    Token.SaveNewToken();
            //    FormsAuthentication.SetAuthCookie(Convert.ToString(Session["UserID"]), false);
            //    e.Result = "2";
            //}
            //else
            //{
            //    e.Result = "Указаны неверные логин или пароль";
            //}
        }
    }
}