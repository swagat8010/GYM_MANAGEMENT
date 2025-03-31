using System;
using System.Data;
using System.Data.SqlClient;
using MySql.Data.MySqlClient;
using System.Configuration;

namespace GYM_MANAGEMENT
{
    public partial class Plans : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPlans();
            }
        }

        private void LoadPlans()
        {
            string connString = ConfigurationManager.ConnectionStrings["GymDB"].ConnectionString;
            using (MySqlConnection conn = new MySqlConnection(connString))
            {
                string query = "SELECT SubscriptionID, PlanName, DurationMonths, Price, Description FROM subscriptions WHERE IsActive = 1";
                MySqlDataAdapter da = new MySqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptPlans.DataSource = dt;
                rptPlans.DataBind();
            }
        }
    }
}
