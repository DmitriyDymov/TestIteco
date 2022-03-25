using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;

namespace TestIteco.Models.Calls
{
    public class CallStatus
    {
        public CallStatus()
        {
            
        }

        public CallStatus(int callStatusID)
        {
            CallStatusID = callStatusID;
            Get();
        }

        public int CallStatusID { get; set; }
        public string CallStatusName { get; set; }

        public void Get()
        {
            if (CallStatusID == 0)
                throw new Exception("CallStatus Get CallStatusID has no value");

            var connectStr = ConfigurationManager.ConnectionStrings["Connection"].ConnectionString;
            using (var connect = new SqlConnection(connectStr))
            {
                connect.Open();

                const string cmdSql = "exec up_CallStatus_Select @CallStatusID";

                using (var cmd = new SqlCommand(cmdSql, connect))
                {
                    cmd.Parameters.Add("CallStatusID", SqlDbType.Int).Value = CallStatusID;

                    using (var table = new DataTable())
                    {
                        using (var adapter = new SqlDataAdapter(cmd))
                        {
                            adapter.Fill(table);

                            var r = table.Rows[0];

                            CallStatusName = Convert.ToString(r["CallStatusName"]);
                        }
                    }
                }
                connect.Close();
            }
        }

        public static List<CallStatus> GetCallStatuses()
        {
            var callStatuses = new List<CallStatus>();

            var connectStr = ConfigurationManager.ConnectionStrings["Connection"].ConnectionString;
            using (var connect = new SqlConnection(connectStr))
            {
                connect.Open();

                const string cmdSql = "exec up_CallStatuses_Select";

                using (var cmd = new SqlCommand(cmdSql, connect))
                {
                    using (var table = new DataTable())
                    {
                        using (var adapter = new SqlDataAdapter(cmd))
                        {
                            adapter.Fill(table);

                            callStatuses.AddRange(from DataRow r in table.Rows select new CallStatus() {CallStatusID = Convert.ToInt32(r["CallStatusID"]), CallStatusName = Convert.ToString(r["CallStatusName"])});
                        }
                    }
                }
                connect.Close();
            }

            return callStatuses;
        }
    }
}