using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;

namespace TestIteco.Models.Conferences
{
    public class ConferenceStatus
    {
        public ConferenceStatus()
        {

        }

        public ConferenceStatus(int conferenceStatusID)
        {
            ConferenceStatusID = conferenceStatusID;
            Get();
        }

        public int ConferenceStatusID { get; set; }
        public string ConferenceStatusName { get; set; }

        public void Get()
        {
            if (ConferenceStatusID == 0)
                throw new Exception("ConferenceStatus Get ConferenceStatusID has no value");

            var connectStr = ConfigurationManager.ConnectionStrings["Connection"].ConnectionString;
            using (var connect = new SqlConnection(connectStr))
            {
                connect.Open();

                const string cmdSql = "exec up_ConferenceStatus_Select @ConferenceStatusID";

                using (var cmd = new SqlCommand(cmdSql, connect))
                {
                    cmd.Parameters.Add("ConferenceStatusID", SqlDbType.Int).Value = ConferenceStatusID;

                    using (var table = new DataTable())
                    {
                        using (var adapter = new SqlDataAdapter(cmd))
                        {
                            adapter.Fill(table);

                            var r = table.Rows[0];

                            ConferenceStatusName = Convert.ToString(r["ConferenceStatusName"]);
                        }
                    }
                }
                connect.Close();
            }

        }

        public static List<ConferenceStatus> GetConferenceStatuses()
        {
            var conferenceStatuses = new List<ConferenceStatus>();

            var connectStr = ConfigurationManager.ConnectionStrings["Connection"].ConnectionString;
            using (var connect = new SqlConnection(connectStr))
            {
                connect.Open();

                const string cmdSql = "exec up_ConferenceStatuses_Select";

                using (var cmd = new SqlCommand(cmdSql, connect))
                {
                    using (var table = new DataTable())
                    {
                        using (var adapter = new SqlDataAdapter(cmd))
                        {
                            adapter.Fill(table);

                            conferenceStatuses.AddRange(from DataRow r in table.Rows select new ConferenceStatus() {ConferenceStatusID = Convert.ToInt32(r["ConferenceStatusID"]), ConferenceStatusName = Convert.ToString(r["ConferenceStatusName"])});
                        }
                    }
                }
                connect.Close();
            }

            return conferenceStatuses;
        }
    }
}