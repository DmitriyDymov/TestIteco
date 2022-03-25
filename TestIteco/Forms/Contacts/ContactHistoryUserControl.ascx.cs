using System;
using DevExpress.Web;
using TestIteco.Models.Contacts;

namespace TestIteco.Forms.Contacts
{
    public partial class ContactHistoryUserControl : System.Web.UI.UserControl
    {
        public int ContactID
        {
            get => Session["ContactHistoryContactID"] == null ? 0 :Convert.ToInt32(Session["ContactHistoryContactID"]);
            set => Session["ContactHistoryContactID"] = value;
        }


        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ContactHistoryGridView_OnCustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            ContactID = Convert.ToInt32(e.Parameters);

            ContactHistoryGridView.DataBind();
        }

        protected void ContactHistoryGridView_OnDataBinding(object sender, EventArgs e)
        {
            if (ContactID == 0) return;

            ContactHistoryGridView.DataSource = ContactHistory.GetContactHistories(ContactID);
        }
    }
}