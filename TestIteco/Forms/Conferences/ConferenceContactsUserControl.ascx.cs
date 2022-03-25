using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using TestIteco.Models.Conferences;

namespace TestIteco.Forms.Conferences
{
    public partial class ConferenceContactsUserControl : System.Web.UI.UserControl
    {

        public int ConferenceID
        {
            get => Session["ConferenceContactsConferenceID"] == null
                ? 0
                : Convert.ToInt32(Session["ConferenceContactsConferenceID"]);
            set => Session["ConferenceContactsConferenceID"] = value;
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ConferenceContactsGridView_OnDataBinding(object sender, EventArgs e)
        {
            ConferenceContactsGridView.DataSource = ConferenceContact.GetConferenceContacts(ConferenceID,0);
        }

        protected void ConferenceContactsGridView_OnCustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            var p = e.Parameters.Split('|');
            var cmd = p[0];
            var conferenceID = Convert.ToInt32(p[1]);

            switch (cmd)
            {
                case "save":
                    var contactID = Convert.ToInt32(p[2]);
                    var newConferenceContact = new ConferenceContact()
                    {
                        ConferenceID = conferenceID,
                        ContactID = contactID
                    };
                    newConferenceContact.Save();
                    break;
                case "load":
                    ConferenceID = conferenceID;
                    break;
                case "delete":
                    var deleteContactID = Convert.ToInt32(p[2]);
                    var deleteConferenceContact = new ConferenceContact
                    {
                        ConferenceID = conferenceID,
                        ContactID = deleteContactID
                    };
                    deleteConferenceContact.Delete();
                    break;
            }

            ConferenceContactsGridView.DataBind();
        }
    }
}