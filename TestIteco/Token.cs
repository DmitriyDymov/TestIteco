using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using DevExpress.XtraRichEdit.Model;

namespace TestIteco
{
    public class Token
    {
        public Token()
        {

        }

        public Token(string tokenID)
        {
            TokenID = tokenID;
            Get();
        }

        public string TokenID { get; set; }
        public string UserID { get; set; }
        public string DeviceID { get; set; }
        public DateTime TokenCreationDate { get; set; } = DateTime.Now;
        public bool TokenEnabled { get; set; }

        public void Save()
        {
            var connectStr = ConfigurationManager.ConnectionStrings["Connection"].ConnectionString;
            using (var connect = new SqlConnection(connectStr))
            {
                connect.Open();

                const string cmdSql = "exec up_Token_Save @TokenID,@UserID,@DeviceID,@TokenEnabled";

                using (var cmd = new SqlCommand(cmdSql, connect))
                {
                    cmd.Parameters.Add("TokenID", SqlDbType.VarChar).Value = TokenID;
                    cmd.Parameters.Add("UserID", SqlDbType.VarChar).Value = UserID;
                    cmd.Parameters.Add("DeviceID", SqlDbType.VarChar).Value = DeviceID;
                    cmd.Parameters.Add("TokenEnabled", SqlDbType.Bit).Value = TokenEnabled?1:0;

                    cmd.ExecuteNonQuery();
                }
                connect.Close();
            }

        }

        public void Get()
        {
            if (string.IsNullOrEmpty(TokenID))
                throw new Exception("TokenID has no value");


            var connectStr = ConfigurationManager.ConnectionStrings["Connection"].ConnectionString;
            using (var connect = new SqlConnection(connectStr))
            {

                connect.Open();

                const string cmdSql = "exec up_Token_Select @TokenID";

                using (var cmd = new SqlCommand(cmdSql, connect))
                {
                    cmd.Parameters.Add("TokenID", SqlDbType.VarChar).Value = TokenID;

                    using (var table = new DataTable())
                    {
                        using (var adapter = new SqlDataAdapter(cmd))
                        {

                            adapter.Fill(table);
                            var r = table.Rows[0];

                            UserID = Convert.ToString(r["UserID"]);
                            DeviceID = Convert.ToString(r["DeviceID"]);
                            TokenCreationDate = Convert.ToDateTime(r["TokenCreationDate"]);
                            TokenEnabled = Convert.ToBoolean(r["TokenEnabled"]);
                        }
                    }
                }
                connect.Close();
            }


        }

        public static string LocalTokenID =>
            HttpContext.Current.Session["TokenID"] == null
                ? ""
                : Convert.ToString(HttpContext.Current.Session["TokenID"]);

        public static bool CheckLocalToken()
        {
            if (string.IsNullOrEmpty(LocalTokenID))
                return false;
                //throw new Exception("LocalTokenID has no value");

            return new Token(LocalTokenID).TokenEnabled;
        }

        public static List<Token> GetTokens()
        {
            var tokens = new List<Token>();


            var connectStr = ConfigurationManager.ConnectionStrings["Connection"].ConnectionString;
            using (var connect = new SqlConnection(connectStr))
            {

                connect.Open();

                const string cmdSql = "exec up_Tokens_Select ";

                using (var cmd = new SqlCommand(cmdSql, connect))
                {

                    using (var table = new DataTable())
                    {

                        using (var adapter = new SqlDataAdapter(cmd))
                        {

                            adapter.Fill(table);

                            foreach (DataRow r in table.Rows)
                            {
                                var token = new Token()
                                {
                                    TokenID = Convert.ToString(r["TokenID"]),
                                    UserID = Convert.ToString(r["UserID"]),
                                    DeviceID = Convert.ToString(r["DeviceID"]),
                                    TokenCreationDate = Convert.ToDateTime(r["TokenCreationDate"]),
                                    TokenEnabled = Convert.ToBoolean(r["TokenEnabled"])
                                };
                                tokens.Add(token);
                            }

                        }
                    }
                }
                connect.Close();
            }

            return tokens;
        }
    }
}