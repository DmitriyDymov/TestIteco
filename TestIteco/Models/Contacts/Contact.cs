using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using TestIteco.Functions;

namespace TestIteco.Models.Contacts
{
    public class Contact
    {
        public Contact()
        {

        }

        public Contact(int contactID)
        {
            ContactID = contactID;
            Get();
        }

        public int ContactID { get; set; }
        public string ContactName { get; set; } = "";
        public string ContactAddress { get; set; } = "";
        public DateTime ContactDateOfBirth { get; set; } = Functions.Constants.DefaultDateTime;
        public string GroupName { get; set; } = "";
        public string GroupDisplayName => string.IsNullOrEmpty(GroupName) ? "<Группа не указана>" : GroupName;
        public string CompanyName { get; set; } = "";
        public string ContactPosition { get; set; } = "";
        public string ContactEmail { get; set; } = "";
        public long ContactPhone { get; set; }
        public string ContactDisplayPhone => PhoneToStr.Convert(ContactPhone);

        public void Save()
        {
            var connectStr = ConfigurationManager.ConnectionStrings["Connection"].ConnectionString;

            using (var connect = new SqlConnection(connectStr))
            {
                connect.Open();

                const string cmdSql = "exec up_Contact_Save @ContactID,@ContactName,@ContactAddress,@ContactDateOfBirth,@GroupName,@CompanyName,@ContactPosition,@ContactEmail,@ContactPhone";

                using (var cmd = new SqlCommand(cmdSql, connect))
                {
                    cmd.Parameters.Add("ContactID", SqlDbType.Int).Value = ContactID;
                    cmd.Parameters.Add("ContactName", SqlDbType.VarChar).Value = ContactName;
                    cmd.Parameters.Add("ContactAddress", SqlDbType.VarChar).Value = ContactAddress;
                    cmd.Parameters.Add("ContactDateOfBirth", SqlDbType.Date).Value = ContactDateOfBirth;
                    cmd.Parameters.Add("GroupName", SqlDbType.VarChar).Value = GroupName;
                    cmd.Parameters.Add("CompanyName", SqlDbType.VarChar).Value = CompanyName;
                    cmd.Parameters.Add("ContactPosition", SqlDbType.VarChar).Value = ContactPosition;
                    cmd.Parameters.Add("ContactEmail", SqlDbType.VarChar).Value = ContactEmail;
                    cmd.Parameters.Add("ContactPhone", SqlDbType.BigInt).Value = ContactPhone;

                    using (var table = new DataTable())
                    {
                        using (var adapter = new SqlDataAdapter(cmd))
                        {
                            adapter.Fill(table);

                            var r = table.Rows[0];

                            ContactID = Convert.ToInt32(r["ContactID"]);
                        }
                    }
                }
                connect.Close();
            }

        }

        public void Get()
        {
            if (ContactID == 0)
                throw new Exception("Contact Get ContactID has no value");

            var connectStr = ConfigurationManager.ConnectionStrings["Connection"].ConnectionString;

            using (var connect = new SqlConnection(connectStr))
            {

                connect.Open();

                const string cmdSql = "exec up_Contact_Select @ContactID";

                using (var cmd = new SqlCommand(cmdSql, connect))
                {
                    cmd.Parameters.Add("ContactID", SqlDbType.Int).Value = ContactID;

                    using (var table = new DataTable())
                    {
                        using (var adapter = new SqlDataAdapter(cmd))
                        {

                            adapter.Fill(table);

                            var r = table.Rows[0];

                            ContactName = Convert.ToString(r["ContactName"]);
                            ContactAddress = Convert.ToString(r["ContactAddress"]);
                            ContactDateOfBirth = Convert.ToDateTime(r["ContactDateOfBirth"]);
                            GroupName = Convert.ToString(r["GroupName"]);
                            CompanyName = Convert.ToString(r["CompanyName"]);
                            ContactPosition = Convert.ToString(r["ContactPosition"]);
                            ContactEmail = Convert.ToString(r["ContactEmail"]);
                            ContactPhone = Convert.ToInt64(r["ContactPhone"]);
                        }
                    }
                }
                connect.Close();
            }
        }

        public void Delete()
        {
            if (ContactID == 0)
                throw new Exception("Contact Get ContactID has no value");

            var connectStr = ConfigurationManager.ConnectionStrings["Connection"].ConnectionString;

            using (var connect = new SqlConnection(connectStr))
            {

                connect.Open();

                const string cmdSql = "exec up_Contact_Delete @ContactID";

                using (var cmd = new SqlCommand(cmdSql, connect))
                {
                    cmd.Parameters.Add("ContactID", SqlDbType.Int).Value = ContactID;

                    cmd.ExecuteNonQuery();
                }
                connect.Close();
            }

        }

        public static List<Contact> GetContacts()
        {
            var contacts = new List<Contact>();

            var connectStr = ConfigurationManager.ConnectionStrings["Connection"].ConnectionString;
            using (var connect = new SqlConnection(connectStr))
            {
                connect.Open();

                const string cmdSql = "exec up_Contacts_Select";

                using (var cmd = new SqlCommand(cmdSql, connect))
                {
                    using (var table = new DataTable())
                    {
                        using (var adapter = new SqlDataAdapter(cmd))
                        {
                            adapter.Fill(table);

                            contacts.AddRange(from DataRow r in table.Rows
                                              select new Contact()
                                              {
                                                  ContactID = Convert.ToInt32(r["ContactID"]),
                                                  ContactName = Convert.ToString(r["ContactName"]),
                                                  ContactAddress = Convert.ToString(r["ContactAddress"]),
                                                  ContactDateOfBirth = Convert.ToDateTime(r["ContactDateOfBirth"]),
                                                  GroupName = Convert.ToString(r["GroupName"]),
                                                  CompanyName = Convert.ToString(r["CompanyName"]),
                                                  ContactPosition = Convert.ToString(r["ContactPosition"]),
                                                  ContactEmail = Convert.ToString(r["ContactEmail"]),
                                                  ContactPhone = Convert.ToInt64(r["ContactPhone"])
                                              });
                        }
                    }
                }
                connect.Close();
            }

            return contacts;
        }
    }
}