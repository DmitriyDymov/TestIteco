using System;
using System.Linq;
using DevExpress.Web;
using TestIteco.Functions;
using TestIteco.Models.Conferences;

namespace TestIteco.Forms.Conferences
{
    public partial class ConferenceEditUserControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ConferenceStatusComboBox.Items.Clear();
            ConferenceStatusComboBox.Items.AddRange((
                from status in ConferenceStatus.GetConferenceStatuses()
                select new ListEditItem(status.ConferenceStatusName)
                ).ToList());
            ConferenceStatusComboBox.SelectedIndex = 0;
        }

        protected void ConferenceLoadCallback_OnCallback(object source, CallbackEventArgs e)
        {
            var conferenceID =  Convert.ToInt32(e.Parameter);
            
            var conference = new Conference(conferenceID);

            e.Result = $"{DateTimeToStr.Convert(conference.ConferencePlannedDate)}|{DateTimeToStr.Convert(conference.ConferenceBeganDate)}|" +
                       $"{conference.ConferenceStatusID}|{conference.ConferenceSubject}|{conference.ConferenceComment}";
        }

        protected void ConferenceSaveCallback_OnCallback(object source, CallbackEventArgs e)
        {
            var p = e.Parameter.Split('|');
            
            var conferenceID = Convert.ToInt32(p[0]);
            var conferencePlannedDate = StrToDateTime.Convert(p[1]);
            var conferenceBeganDate = StrToDateTime.Convert(p[2]);
            var conferenceStatusID = Convert.ToInt32(p[3]);
            var conferenceSubject = p[4];
            var conferenceComment = p[5];

            var conference = conferenceID == 0 ? new Conference() : new Conference(conferenceID);

            conference.ConferencePlannedDate = conferencePlannedDate;
            conference.ConferenceBeganDate = conferenceBeganDate;
            conference.ConferenceStatusID = conferenceStatusID;
            conference.ConferenceSubject = conferenceSubject;
            conference.ConferenceComment = conferenceComment;

            conference.Save();

            e.Result = $"1|{conference.ConferenceID}";
        }
    }
}