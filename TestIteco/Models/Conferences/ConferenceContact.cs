using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using TestIteco.Models.Contacts;

namespace TestIteco.Models.Conferences
{
    public class ConferenceContact
    {
        public int ConferenceID { get; set; }
        public int ContactID { get; set; }
        public Conference Conference => new Conference(ConferenceID);
        public Contact Contact => new Contact(ContactID);

        public void Save()
        {
            var connectStr = ConfigurationManager.ConnectionStrings["Connection"].ConnectionString;
            using (var connect = new SqlConnection(connectStr))
            {
                connect.Open();

                const string cmdSql = "exec up_ConferenceContact_Save @ConferenceID,@ContactID";

                using (var cmd = new SqlCommand(cmdSql, connect))
                {
                    cmd.Parameters.Add("ConferenceID", SqlDbType.Int).Value = ConferenceID;
                    cmd.Parameters.Add("ContactID", SqlDbType.Int).Value = ContactID;

                    cmd.ExecuteNonQuery();
                }
                connect.Close();
            }
        }

        public void Delete()
        {
            var connectStr = ConfigurationManager.ConnectionStrings["Connection"].ConnectionString;
            using (var connect = new SqlConnection(connectStr))
            {

                connect.Open();

                const string cmdSql = "exec up_ConferenceContact_Delete @ConferenceID,@ContactID";

                using (var cmd = new SqlCommand(cmdSql, connect))
                {
                    cmd.Parameters.Add("ConferenceID", SqlDbType.Int).Value = ConferenceID;
                    cmd.Parameters.Add("ContactID", SqlDbType.Int).Value = ContactID;

                    cmd.ExecuteNonQuery();
                }
                connect.Close();
            }

        }

        public static List<ConferenceContact> GetConferenceContacts(int conferenceID,int contactID)
        {
            var conferenceContacts = new List<ConferenceContact>();

            var connectStr = ConfigurationManager.ConnectionStrings["Connection"].ConnectionString;
            using (var connect = new SqlConnection(connectStr))
            {
                connect.Open();

                const string cmdSql = "exec up_ConferenceContacts_Select @ConferenceID,@ContactID";

                using (var cmd = new SqlCommand(cmdSql, connect))
                {
                    cmd.Parameters.Add("ConferenceID", SqlDbType.Int).Value = conferenceID;
                    cmd.Parameters.Add("ContactID", SqlDbType.Int).Value = contactID;

                    using (var table = new DataTable())
                    {
                        using (var adapter = new SqlDataAdapter(cmd))
                        {
                            adapter.Fill(table);

                            conferenceContacts.AddRange(from DataRow r in table.Rows select new ConferenceContact() {ConferenceID = Convert.ToInt32(r["ConferenceID"]), ContactID = Convert.ToInt32(r["ContactID"])});
                        }
                    }
                }
                connect.Close();
            }

            return conferenceContacts;
        }
    }
}