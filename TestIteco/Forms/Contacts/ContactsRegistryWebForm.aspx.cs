using System;
using System.Linq;
using DevExpress.Web;
using TestIteco.Models.Contacts;

namespace TestIteco.Forms.Contacts
{
    public partial class ContactsRegistryWebForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            NavigationTreeRefresh();
        }

        protected void ContactsGridView_OnDataBinding(object sender, EventArgs e)
        {
            ContactsGridView.DataSource = Contact.GetContacts();
        }

        protected void NavigationTreeCallbackPanel_OnCallback(object sender, CallbackEventArgsBase e)
        {
            NavigationTreeRefresh();
        }

        private void NavigationTreeRefresh()
        {
            NavigationTreeView.Nodes.Clear();

            var companies = (from IGrouping<string, Contact> gr in
                    (from Contact contact in Contact.GetContacts()
                        group contact by contact.GroupDisplayName
                        into groups
                        select groups)
                orderby gr.Key
                select new TreeViewNode($"{gr.Key} ({gr.Count()})"));

            NavigationTreeView.Nodes.Add("Все группы");
            NavigationTreeView.Nodes.AddRange(companies);
        }

        protected void ContactsGridView_OnCustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            var p = e.Parameters.Split('|');

            var cmd = p[0];
            var contactID = Convert.ToInt32(p[1]);

            switch (cmd)
            {
                case "delete":
                    var contact = new Contact(contactID);
                    contact.Delete();
                    ContactsGridView.DataBind();
                    break;
            }
        }
    }
}