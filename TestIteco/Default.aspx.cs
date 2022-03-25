using System;
using System.IO;

namespace TestIteco {
    public partial class Default : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            Response.Redirect("/ContactsRegistry", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}