using System;
using System.Linq;
using DevExpress.Web;
using TestIteco.Functions;
using TestIteco.Models.Calls;
using TestIteco.Models.Contacts;

namespace TestIteco.Forms.Calls
{
    public partial class CallEditUserControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            CallStatusComboBox.Items.Clear();
            CallStatusComboBox.Items.AddRange((
                from status in CallStatus.GetCallStatuses()
                select new ListEditItem(status.CallStatusName)
                ).ToList());
            CallStatusComboBox.SelectedIndex = 0;


        }

        protected void CallNewCallback_OnCallback(object source, CallbackEventArgs e)
        {
            var p = e.Parameter.Split('|');

            var sourceContactID = Convert.ToInt32(p[0]);
            var targetContactID = Convert.ToInt32(p[1]);

            var sourceName = "";
            var targetName = "";

            if (sourceContactID == 0)
            {
                sourceName = "";
            }
            else
            {
                var sourceContact = new Contact(sourceContactID);
                sourceName = $"{sourceContact.ContactName}, {sourceContact.ContactPhone }";
            }

            if (targetContactID == 0)
            {
                targetName = "";
            }
            else
            {
                var targetContact = new Contact(targetContactID);
                targetName = $"{targetContact.ContactName }, {targetContact.ContactPhone}";
            }

            e.Result = $"{sourceName}|{targetName}";
        }

        protected void CallSaveCallback_OnCallback(object source, CallbackEventArgs e)
        {
            var p = e.Parameter.Split('|');

            var callID = Convert.ToInt32(p[0]);
            var sourceContactID = Convert.ToInt32(p[1]);
            var targetContactID = Convert.ToInt32(p[2]);
            var callStatusID = Convert.ToInt32(p[3]) + 1;
            var callDate = Functions.StrToDateTime.Convert(p[4]);
            var callDuration = Convert.ToInt32(p[5]);
            var callSubject = p[6];
            var callComment = p[7];

            if (sourceContactID == 0) return;
            if (targetContactID == 0) return;
            if (!CallStatus.GetCallStatuses().Any(r => r.CallStatusID == callStatusID)) return;

            var call = callID == 0 ? new Call() : new Call(callID);

            call.SourceContactID = sourceContactID;
            call.TargetContactID = targetContactID;
            call.CallStatusID = callStatusID;
            call.CallDate = callDate;
            call.CallDuration = callDuration;
            call.CallSubject = callSubject;
            call.CallComment = callComment;

            call.Save();

            e.Result = "1";
        }

        protected void CallLoadCallback_OnCallback(object source, CallbackEventArgs e)
        {
            var p = e.Parameter.Split('|');

            var callID = Convert.ToInt32(p[0]);

            if (callID == 0) return;

            var call = new Call(callID);

            var res = $"{call.SourceContactID}|{call.TargetContactID}|" +
                      $"{call.SourceContact.ContactName}, {call.SourceContact.ContactPhone}|{call.TargetContact.ContactName}, {call.TargetContact.ContactPhone}|" +
                      $"{call.CallStatusID - 1}|{DateTimeToStr.Convert(call.CallDate)}|{call.CallDuration}|{call.CallSubject}|{call.CallComment}";

            e.Result = res;
        }
    }
}