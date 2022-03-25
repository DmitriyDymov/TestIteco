using System;
using System.Linq;
using DevExpress.Web;
using TestIteco.Models.Calls;

namespace TestIteco.Forms.Calls
{
    public partial class CallRegistryWebForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            NavigationRefresh();
        }

        protected void NavigationTreeCallbackPanel_OnCallback(object sender, CallbackEventArgsBase e)
        {
            NavigationRefresh();
        }

        private void NavigationRefresh()
        {
            var calls = Call.GetCalls(0, 0);

            NavigationTreeView.Nodes.Clear();
            NavigationTreeView.Nodes.Add("Все статусы");
            NavigationTreeView.Nodes.AddRange((
                from status in CallStatus.GetCallStatuses()
                select new TreeViewNode($"{status.CallStatusName} ({calls.Count(r=>r.CallStatusID == status.CallStatusID)})")
            ).ToList());
        }

        protected void CallsGridView_OnDataBinding(object sender, EventArgs e)
        {
            CallsGridView.DataSource = Call.GetCalls(0, 0);
        }

        protected void CallsGridView_OnCustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            var p = e.Parameters.Split('|');

            var cmd = p[0];
            var callID = Convert.ToInt32(p[1]);

            switch (cmd)
            {
                case "delete":
                    var contact = new Call(callID);
                    contact.Delete();
                    CallsGridView.DataBind();
                    break;
            }
        }
    }
}