using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace TestIteco.Models.Conferences
{
    public class Conference
    {
        public int ConferenceID { get; set; }
        public DateTime ConferencePlannedDate { get; set; }
        public DateTime ConferenceBeganDate { get; set; }
        public int ConferenceStatusID { get; set; }
        public string ConferenceSubject { get; set; }
        public string ConferenceComment { get; set; }

        public void Save()
        {
            var connectStr = ConfigurationManager.ConnectionStrings["Connection"].ConnectionString;
            using (var connect = new SqlConnection(connectStr))
            {
                connect.Open();

                const string cmdSql = "exec up_Conference_Save @ConferenceID,@ConferencePlannedDate,@ConferenceBeganDate,@ConferenceStatusID,@ConferenceSubject,@ConferenceComment";

                using (var cmd = new SqlCommand(cmdSql, connect))
                {
                    cmd.Parameters.Add("ConferenceID", SqlDbType.Int).Value = ConferenceID;
                    cmd.Parameters.Add("ConferencePlannedDate", SqlDbType.DateTime).Value = ConferencePlannedDate;
                    cmd.Parameters.Add("ConferenceBeganDate", SqlDbType.DateTime).Value = ConferenceBeganDate;
                    cmd.Parameters.Add("ConferenceStatusID", SqlDbType.Int).Value = ConferenceStatusID;
                    cmd.Parameters.Add("ConferenceSubject", SqlDbType.VarChar).Value = ConferenceSubject;
                    cmd.Parameters.Add("ConferenceComment", SqlDbType.Text).Value = ConferenceComment;

                    using (var table = new DataTable())
                    {
                        using (var adapter = new SqlDataAdapter(cmd))
                        {
                            adapter.Fill(table);

                            var r = table.Rows[0];

                            ConferenceID = Convert.ToInt32(r["ConferenceID"]);
                            ConferencePlannedDate = Convert.ToDateTime(r["ConferencePlannedDate"]);
                            ConferenceBeganDate = Convert.ToDateTime(r["ConferenceBeganDate"]);
                            ConferenceStatusID = Convert.ToInt32(r["ConferenceStatusID"]);
                            ConferenceSubject = Convert.ToString(r["ConferenceSubject"]);
                            ConferenceComment = Convert.ToString(r["ConferenceComment"]);
                        }
                    }
                }
                connect.Close();
            }

        }

        public void Get()
        {
            var connectStr = ConfigurationManager.ConnectionStrings["Connection"].ConnectionString;
            using (var connect = new SqlConnection(connectStr))
            {
                connect.Open();

                const string cmdSql = "exec up_Conference_Select @ConferenceID";

                using (var cmd = new SqlCommand(cmdSql, connect))
                {
                    cmd.Parameters.Add("ConferenceID", SqlDbType.Int).Value = ConferenceID;

                    using (var table = new DataTable())
                    {
                        using (var adapter = new SqlDataAdapter(cmd))
                        {
                            adapter.Fill(table);

                            var r = table.Rows[0];

                            ConferencePlannedDate = Convert.ToDateTime(r["ConferencePlannedDate"]);
                            ConferenceBeganDate = Convert.ToDateTime(r["ConferenceBeganDate"]);
                            ConferenceStatusID = Convert.ToInt32(r["ConferenceStatusID"]);
                            ConferenceSubject = Convert.ToString(r["ConferenceSubject"]);
                            ConferenceComment = Convert.ToString(r["ConferenceComment"]);
                        }
                    }
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

                const string cmdSql = "exec up_Conference_Delete @ConferenceID";

                using (var cmd = new SqlCommand(cmdSql, connect))
                {
                    cmd.Parameters.Add("ConferenceID", SqlDbType.Int).Value = ConferenceID;

                    cmd.ExecuteNonQuery();
                }
                connect.Close();
            }
        }

        public static List<Conference> GetConferences()
        {
            var conferences = new List<Conference>();

            var connectStr = ConfigurationManager.ConnectionStrings["Connection"].ConnectionString;
            using (var connect = new SqlConnection(connectStr))
            {
                connect.Open();

                const string cmdSql = "exec up_Conferences_Select";

                using (var cmd = new SqlCommand(cmdSql, connect))
                {
                    using (var table = new DataTable())
                    {
                        using (var adapter = new SqlDataAdapter(cmd))
                        {
                            adapter.Fill(table);

                            conferences.AddRange(from DataRow r in table.Rows
                            select new Conference()
                            {
                                ConferenceID = Convert.ToInt32(r["ConferenceID"]),
                                ConferencePlannedDate = Convert.ToDateTime(r["ConferencePlannedDate"]),
                                ConferenceBeganDate = Convert.ToDateTime(r["ConferenceBeganDate"]),
                                ConferenceStatusID = Convert.ToInt32(r["ConferenceStatusID"]),
                                ConferenceSubject = Convert.ToString(r["ConferenceSubject"]),
                                ConferenceComment = Convert.ToString(r["ConferenceComment"])
                            });
                        }
                    }
                }
                connect.Close();
            }

            return conferences;
        }
    }
}