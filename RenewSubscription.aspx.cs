using MySql.Data.MySqlClient;
using System;
using System.Web.UI;

namespace GYM_MANAGEMENT
{
    public partial class RenewSubscription : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // On first load, populate the subscription plans.
            if (!IsPostBack)
            {
                LoadSubscriptionPlans();
            }
        }

        private void LoadSubscriptionPlans()
        {
            // Database connection string
            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["GymDB"].ToString();

            // SQL query to get active subscription plans
            string query = "SELECT SubscriptionID, PlanName FROM subscriptions WHERE IsActive = 1";

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    try
                    {
                        conn.Open();
                        MySqlDataReader reader = cmd.ExecuteReader();

                        // Bind the data to the DropDownList
                        ddlSubscriptionPlans.DataSource = reader;
                        ddlSubscriptionPlans.DataTextField = "PlanName";
                        ddlSubscriptionPlans.DataValueField = "SubscriptionID";
                        ddlSubscriptionPlans.DataBind();
                    }
                    catch (Exception ex)
                    {
                        Response.Write("<script>alert('Error loading subscription plans: " + ex.Message + "');</script>");
                    }
                }
            }
        }

        protected void btnRenew_Click(object sender, EventArgs e)
        {
            // Retrieve the username from the Session.
            string username = Session["username"] as string;
            if (string.IsNullOrEmpty(username))
            {
                Response.Write("<script>alert('Error: Session expired. Please log in again.');</script>");
                return;
            }

            // Retrieve the selected subscription plan from the DropDownList.
            string subscriptionID = ddlSubscriptionPlans.SelectedValue;
            if (string.IsNullOrEmpty(subscriptionID))
            {
                Response.Write("<script>alert('Please select a subscription plan.');</script>");
                return;
            }

            try
            {
                // Get the user ID using the username from the session.
                string userID = GetUserID(username);
                if (string.IsNullOrEmpty(userID))
                {
                    Response.Write("<script>alert('User not found.');</script>");
                    return;
                }

                // Renew the subscription in the database.
                RenewUserSubscription(userID, subscriptionID);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error during renewal: " + ex.Message + "');</script>");
            }
        }

        private string GetUserID(string username)
        {
            // Database connection string
            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["GymDB"].ToString();
            string userID = string.Empty;

            // Query to get the UserID based on the username
            string query = "SELECT UserID FROM users WHERE Username = @Username";

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Username", username);
                    conn.Open();

                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            userID = reader["UserID"].ToString();
                        }
                    }
                }
            }

            return userID;
        }

        private void RenewUserSubscription(string userID, string subscriptionID)
        {
            // Database connection string
            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["GymDB"].ToString();
            string query = "UPDATE Members SET SubscriptionID = @SubscriptionPlanID WHERE UserID = @UserID";

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userID);
                    cmd.Parameters.AddWithValue("@SubscriptionPlanID", subscriptionID);
                    conn.Open();
                    cmd.ExecuteNonQuery();

                    // After updating, redirect to Dashboard.
                    Response.Redirect("Dashboard.aspx");
                }
            }
        }
    }
}
