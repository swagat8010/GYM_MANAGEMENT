using System;
using System.Collections.Generic;
using System.Web.UI;
using MySql.Data.MySqlClient;

namespace GYM_MANAGEMENT
{
    public partial class ManageSubscriptions : Page
    {
        // Connection string for MySQL database
        private string connectionString = "server=localhost;database=gymmanagementdb;user=root;password=2004";

        // Page Load event: binds data to GridView on first load
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Only bind subscriptions if data hasn't been inserted yet
                if (Session["SubscriptionInserted"] == null || (bool)Session["SubscriptionInserted"] == false)
                {
                    BindSubscriptionsGrid();
                }
            }
        }

        // Method to bind subscriptions to the GridView
        private void BindSubscriptionsGrid()
        {
            string query = "SELECT * FROM subscriptions";
            List<Subscription> subscriptions = new List<Subscription>();

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    conn.Open();
                    MySqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        Subscription subscription = new Subscription
                        {
                            SubscriptionID = reader.GetInt32("SubscriptionID"),
                            PlanName = reader.GetString("PlanName"),
                            DurationMonths = reader.GetInt32("DurationMonths"),
                            Price = reader.GetDecimal("Price"),
                            Description = reader.IsDBNull(reader.GetOrdinal("Description")) ? "" : reader.GetString("Description"),
                            IsActive = reader.GetBoolean("IsActive"),
                            CreatedDate = reader.GetDateTime("CreatedDate").ToString("yyyy-MM-dd")
                        };
                        subscriptions.Add(subscription);
                    }
                }
            }

            GridViewSubscriptions.DataSource = subscriptions;
            GridViewSubscriptions.DataBind();
        }

        // Method to handle adding a new subscription
        protected void AddSubscription_Click(object sender, EventArgs e)
        {
            string planName = Request.Form["PlanName"];
            int durationMonths = int.Parse(Request.Form["DurationMonths"]);
            decimal price = decimal.Parse(Request.Form["Price"]);
            string description = Request.Form["Description"];
            bool isActive = Request.Form["IsActive"] == "on" ? true : false;

            string query = "INSERT INTO subscriptions (PlanName, DurationMonths, Price, Description, IsActive) " +
                           "VALUES (@PlanName, @DurationMonths, @Price, @Description, @IsActive)";

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@PlanName", planName);
                    cmd.Parameters.AddWithValue("@DurationMonths", durationMonths);
                    cmd.Parameters.AddWithValue("@Price", price);
                    cmd.Parameters.AddWithValue("@Description", description);
                    cmd.Parameters.AddWithValue("@IsActive", isActive);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            // Rebind the GridView after adding a new subscription
            BindSubscriptionsGrid();

            // Show success message using JavaScript alert
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Subscription added successfully!');", true);

            // Redirect to avoid form resubmission on refresh
            Response.Redirect(Request.Url.ToString(), true); // true means terminate the response
        }


        // Method to handle the deletion of a subscription from GridView
        protected void GridViewSubscriptions_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {
            int subscriptionID = Convert.ToInt32(GridViewSubscriptions.DataKeys[e.RowIndex].Value);
            string query = "DELETE FROM subscriptions WHERE SubscriptionID = @SubscriptionID";

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@SubscriptionID", subscriptionID);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            // Rebind the GridView after deletion
            BindSubscriptionsGrid();

            // Show success message using JavaScript alert
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Subscription deleted successfully!');", true);
        }

        // Define Subscription class
        public class Subscription
        {
            public int SubscriptionID { get; set; }
            public string PlanName { get; set; }
            public int DurationMonths { get; set; }
            public decimal Price { get; set; }
            public string Description { get; set; }
            public bool IsActive { get; set; }
            public string CreatedDate { get; set; }
        }
    }
}