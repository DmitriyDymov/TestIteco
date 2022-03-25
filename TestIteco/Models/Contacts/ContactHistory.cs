using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using TestIteco.Functions;

namespace TestIteco.Models.Contacts
{
    public class ContactHistory
    {
        public int CallID { get; set; }
        public int ConferenceID { get; set; }
        public DateTime ActionDate { get; set; }
        public string ActionName { get; set; }
        public string ActionStatus { get; set; }
        public string ActionDescription { get; set; }
        public long ContactPhone { get; set; }

        public string ActionFullDescription =>
            CallID == 0 ? ActionDescription : $"{ActionDescription}, {PhoneToStr.Convert(ContactPhone)}";

        public static List<ContactHistory> GetContactHistories(int contactID)
        {
            var contactHistories = new List<ContactHistory>();

            var connectStr = ConfigurationManager.ConnectionStrings["Connection"].ConnectionString;
            using (var connect = new SqlConnection(connectStr))
            {
                connect.Open();

                const string cmdSql = "exec up_ContactHistory_select @ContactID";

                using (var cmd = new SqlCommand(cmdSql, connect))
                {
                    cmd.Parameters.Add("ContactID", SqlDbType.Int).Value = contactID;

                    using (var table = new DataTable())
                    {
                        using (var adapter = new SqlDataAdapter(cmd))
                        {
                            adapter.Fill(table);

                            foreach (DataRow r in table.Rows)
                            {
                                var contactHistory = new ContactHistory()
                                {
                                    CallID = Convert.ToInt32(r["CallID"]),
                                    ConferenceID = Convert.ToInt32(r["ConferenceID"]),
                                    ActionDate = Convert.ToDateTime(r["ActionDate"]),
                                    ActionName = Convert.ToString(r["ActionName"]),
                                    ActionStatus = Convert.ToString(r["ActionStatus"]),
                                    ActionDescription = Convert.ToString(r["ActionDescription"]),
                                    ContactPhone = Convert.ToInt64(r["ContactPhone"])
                                };

                                contactHistories.Add(contactHistory);
                            }
                        }
                    }
                }
                connect.Close();
            }

            return contactHistories;
        }
    }
}