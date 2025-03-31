using System;
using System.Data;
using MySql.Data.MySqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace GYM_MANAGEMENT
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
               /* LoadPlans(); //*/
            }
        }

        //private void LoadPlans()
        //{
        //    // SQL query to fetch active subscription plans from the database
        //    string query = "SELECT SubscriptionID, PlanName, DurationMonths, Price, Description FROM subscriptions WHERE IsActive = 1";

        //    // SQL connection and execution
        //    using (MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["GymDB"].ConnectionString))
        //    {
        //        MySqlCommand cmd = new MySqlCommand(query, conn);
        //        conn.Open();
        //        MySqlDataReader reader = cmd.ExecuteReader();

        //        // Bind the data to the Repeater control
        //        rptPlans.DataSource = reader;
        //        rptPlans.DataBind();
        //    }
        //}

        protected void SelectPlan_Click(object sender, CommandEventArgs e)
        {
            if (e.CommandArgument != null)
            {
                // Retrieve the selected plan's ID
                int selectedSubscriptionId = int.Parse(e.CommandArgument.ToString());

                // Redirect to the registration page, passing the selected plan ID
                Response.Redirect($"Register.aspx?subscriptionId={selectedSubscriptionId}");
            }
        }
    }
}
