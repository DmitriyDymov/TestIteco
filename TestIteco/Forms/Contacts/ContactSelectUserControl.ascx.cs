using System;
using System.Linq;
using DevExpress.Web;
using TestIteco.Models.Contacts;

namespace TestIteco.Forms.Contacts
{
    public partial class ContactSelectUserControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ContactSelectGridView_OnDataBinding(object sender, EventArgs e)
        {
            if (Session["CurrentContactIDForCall"] == null) return;

            var currentContactID = Convert.ToInt32(Session["CurrentContactIDForCall"]);

            ContactSelectGridView.DataSource = Contact.GetContacts().Where(r=>r.ContactID != currentContactID);
        }

        protected void ContactSelectGridView_OnCustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            var currentContactID = Convert.ToInt32(e.Parameters);
            Session["CurrentContactIDForCall"] = currentContactID;
            ContactSelectGridView.DataBind();
        }
    }
}