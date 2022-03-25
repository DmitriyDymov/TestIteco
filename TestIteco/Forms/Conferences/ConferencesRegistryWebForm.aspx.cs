using System;
using System.Linq;
using DevExpress.Web;
using TestIteco.Models.Conferences;

namespace TestIteco.Forms.Conferences
{
    public partial class ConferencesRegistryWebForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            NavigationRefresh();
        }


        private void NavigationRefresh()
        {
            var conferences = Conference.GetConferences();

            NavigationTreeView.Nodes.Clear();
            NavigationTreeView.Nodes.Add("Все статусы");
            NavigationTreeView.Nodes.AddRange((
                from status in ConferenceStatus.GetConferenceStatuses()
                select new TreeViewNode($"{status.ConferenceStatusName} ({conferences.Count(r => r.ConferenceStatusID == status.ConferenceStatusID)})")
            ).ToList());
        }

        protected void NavigationTreeCallbackPanel_OnCallback(object sender, CallbackEventArgsBase e)
        {
            NavigationRefresh();
        }

        protected void ConferencesGridView_OnDataBinding(object sender, EventArgs e)
        {
            ConferencesGridView.DataSource = Conference.GetConferences();
        }

        protected void ConferencesGridView_OnCustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            var p = e.Parameters.Split('|');

            var cmd = p[0];
            var conferenceID = Convert.ToInt32(p[1]);

            switch (cmd)
            {
                case "delete":
                    var contact = new Conference(conferenceID);
                    contact.Delete();
                    ConferencesGridView.DataBind();
                    break;
            }
        }
    }
}