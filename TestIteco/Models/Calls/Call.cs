using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using TestIteco.Models.Contacts;

namespace TestIteco.Models.Calls
{
    public class Call
    {
        public Call()
        {

        }

        public Call(int callID)
        {
            CallID = callID;
            Get();
        }

        public int CallID { get; set; }
        public int SourceContactID { get; set; }
        public int TargetContactID { get; set; }
        public Contact SourceContact => new Contact(SourceContactID);
        public Contact TargetContact => new Contact(TargetContactID);
        public DateTime CallDate { get; set; } = Functions.Constants.DefaultDateTime;
        public int CallDuration { get; set; }
        public string CallSubject { get; set; } = "";
        public string CallComment { get; set; } = "";
        public int CallStatusID { get; set; } = 1;
        public CallStatus CallStatus => new CallStatus(CallStatusID);



        public void Save()
        {
            var connectStr = ConfigurationManager.ConnectionStrings["Connection"].ConnectionString;
            using (var connect = new SqlConnection(connectStr))
            {
                connect.Open();

                const string cmdSql = "exec up_Call_Save @CallID,@SourceContactID,@TargetContactID,@CallDate,@CallDuration,@CallSubject,@CallComment,@CallStatusID";

                using (var cmd = new SqlCommand(cmdSql, connect))
                {
                    cmd.Parameters.Add("CallID", SqlDbType.Int).Value = CallID;
                    cmd.Parameters.Add("SourceContactID", SqlDbType.Int).Value = SourceContactID;
                    cmd.Parameters.Add("TargetContactID", SqlDbType.Int).Value = TargetContactID;
                    cmd.Parameters.Add("CallDate", SqlDbType.DateTime).Value = CallDate;
                    cmd.Parameters.Add("CallDuration", SqlDbType.Int).Value = CallDuration;
                    cmd.Parameters.Add("CallSubject", SqlDbType.VarChar).Value = CallSubject;
                    cmd.Parameters.Add("CallComment", SqlDbType.VarChar).Value = CallComment;
                    cmd.Parameters.Add("CallStatusID", SqlDbType.VarChar).Value = CallStatusID;

                    using (var table = new DataTable())
                    {
                        using (var adapter = new SqlDataAdapter(cmd))
                        {
                            adapter.Fill(table);

                            var r = table.Rows[0];

                            CallID = Convert.ToInt32(r["CallID"]);
                        }
                    }
                }
                connect.Close();
            }

        }

        public void Get()
        {
            if (CallID == 0)
                throw new Exception("Call Get CallID has no value");

            var connectStr = ConfigurationManager.ConnectionStrings["Connection"].ConnectionString;
            using (var connect = new SqlConnection(connectStr))
            {
                connect.Open();

                const string cmdSql = "exec up_Call_Select @CallID";

                using (var cmd = new SqlCommand(cmdSql, connect))
                {
                    cmd.Parameters.Add("CallID", SqlDbType.Int).Value = CallID;

                    using (var table = new DataTable())
                    {
                        using (var adapter = new SqlDataAdapter(cmd))
                        {
                            adapter.Fill(table);

                            var r = table.Rows[0];

                            SourceContactID = Convert.ToInt32(r["SourceContactID"]);
                            TargetContactID = Convert.ToInt32(r["TargetContactID"]);
                            CallDate = Convert.ToDateTime(r["CallDate"]);
                            CallDuration = Convert.ToInt32(r["CallDuration"]);
                            CallSubject = Convert.ToString(r["CallSubject"]);
                            CallComment = Convert.ToString(r["CallComment"]);
                            CallStatusID = Convert.ToInt32(r["CallStatusID"]);
                        }
                    }
                }
                connect.Close();
            }
        }

        public void Delete()
        {
            if (CallID == 0)
                throw new Exception("Call Get CallID has no value");

            var connectStr = ConfigurationManager.ConnectionStrings["Connection"].ConnectionString;
            using (var connect = new SqlConnection(connectStr))
            {
                connect.Open();

                const string cmdSql = "exec up_Call_Delete @CallID";

                using (var cmd = new SqlCommand(cmdSql, connect))
                {
                    cmd.Parameters.Add("CallID", SqlDbType.Int).Value = CallID;

                    cmd.ExecuteNonQuery();
                }
                connect.Close();
            }

        }

        public static List<Call> GetCalls(int sourceContactID, int targetContactID)
        {
            var calls = new List<Call>();

            var connectStr = ConfigurationManager.ConnectionStrings["Connection"].ConnectionString;
            using (var connect = new SqlConnection(connectStr))
            {

                connect.Open();

                const string cmdSql = "exec up_Calls_Select @SourceContactID,@TargetContactID";

                using (var cmd = new SqlCommand(cmdSql, connect))
                {
                    cmd.Parameters.Add("SourceContactID", SqlDbType.Int).Value = sourceContactID;
                    cmd.Parameters.Add("TargetContactID", SqlDbType.Int).Value = targetContactID;

                    using (var table = new DataTable())
                    {

                        using (var adapter = new SqlDataAdapter(cmd))
                        {
                            adapter.Fill(table);

                            calls.AddRange(from DataRow r in table.Rows
                                           select new Call()
                                           {
                                               CallID = Convert.ToInt32(r["CallID"]),
                                               SourceContactID = Convert.ToInt32(r["SourceContactID"]),
                                               TargetContactID = Convert.ToInt32(r["TargetContactID"]),
                                               CallDate = Convert.ToDateTime(r["CallDate"]),
                                               CallDuration = Convert.ToInt32(r["CallDuration"]),
                                               CallSubject = Convert.ToString(r["CallSubject"]),
                                               CallComment = Convert.ToString(r["CallComment"]),
                                               CallStatusID = Convert.ToInt32(r["CallStatusID"])
                                           });
                        }
                    }
                }
                connect.Close();
            }

            return calls;
        }
    }
}