using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace TestIteco.Routes
{
    public class Route
    {
        public string RouteID { get; set; }
        public string RouteURL { get; set; }
        public string RouteFile { get; set; }

        public static List<Route> GetRoutes()
        {
            var routes = new List<Route>();

            var connectStr = ConfigurationManager.ConnectionStrings["Connection"].ConnectionString;

            var connect = new SqlConnection(connectStr);

            connect.Open();

            const string cmdSql = "select * from Routes where Deleted = 0";

            using (var cmd = new SqlCommand(cmdSql, connect))
            {
                using (var table = new DataTable())
                {
                    using (var adapter = new SqlDataAdapter(cmd))
                    {

                        adapter.Fill(table);

                        connect.Close();

                        routes.AddRange(from DataRow r in table.Rows select new Route {RouteID = Convert.ToString(r["RouteID"]), RouteURL = Convert.ToString(r["RouteURL"]), RouteFile = Convert.ToString(r["RouteFile"])});
                    }
                }
            }
            return routes;
        }
    }
}