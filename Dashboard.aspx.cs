using System;
using MySql.Data.MySqlClient;
using System.Configuration;
using System.Web.UI;

namespace GYM_MANAGEMENT
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected string userID;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["Role"].ToString() != "Member")
            {
                Response.Redirect("Login.aspx");
            }
            if (Session["UserID"] == null)
            {
                Response.Write("<script>alert('Session UserID is null! Redirecting to login.');</script>");
                Response.Redirect("login.aspx"); // Redirect to login if session expired
                return;
            }

            string sessionUserID = Session["UserID"].ToString();
            string username = Session["Username"] as string;

            if (string.IsNullOrEmpty(username))
            {
                Response.Write("<script>alert('Session Username is null! Redirecting to login.');</script>");
                Response.Redirect("login.aspx");
                return;
            }

           

           
                userID = GetUserID(username);
                if (!string.IsNullOrEmpty(userID))
                {
                    LoadUserData();
                }
                else
                {
                    Response.Write("<script>alert('UserID retrieval failed!');</script>");
                }
            
        }


        // Method to get UserID based on Username
        private string GetUserID(string username)
        {
            string connStr = ConfigurationManager.ConnectionStrings["GymDB"].ToString();
            string userID = string.Empty;

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                string query = "SELECT UserID FROM members WHERE UserID IN (SELECT UserID FROM users WHERE Username = @Username)";
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
                        else
                        {
                            Response.Write("<script>alert('No matching UserID found!');</script>");
                        }
                    }
                }
            }
            return userID;
        }
        protected void btnMarkAttendance_Click(object sender, EventArgs e)
        {
            Response.Redirect("MarkAttendance.aspx");
        }


        // Method to load user data
        private void LoadUserData()
        {
            string connStr = ConfigurationManager.ConnectionStrings["GymDB"].ToString();

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                string query = "SELECT m.Name, m.Email, s.PlanName, s.Price, m.EndDate, s.DurationMonths " +
                "FROM members m " +
                "INNER JOIN subscriptions s ON m.SubscriptionID = s.SubscriptionID " +
                "WHERE m.UserID = @UserID";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userID);
                    conn.Open();

                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // Load user details
                            lblName.Text = reader["Name"].ToString();
                            lblEmail.Text = reader["Email"].ToString();

                            // Load subscription details
                            lblSubscription.Text = reader["PlanName"].ToString();
                            if (reader["EndDate"] != DBNull.Value)
                            {
                                DateTime subscriptionEndDate = Convert.ToDateTime(reader["EndDate"]);
                                lblExpiryDate.Text = subscriptionEndDate.ToString("dd/MM/yyyy");
                            }
                            else
                            {
                                lblExpiryDate.Text = "No expiry date available";
                            }
                            lblPlanName.Text = reader["PlanName"].ToString();
                            lblPlanDuration.Text = reader["DurationMonths"].ToString();
                            lblPrice.Text = reader["Price"].ToString();
                        }
                        else
                        {
                            Response.Write("<script>alert('Member data not found!');</script>");
                        }
                    }
                }
            }
        }

        protected void btnEditProfile_Click(object sender, EventArgs e)
        {
            string username = Session["Username"] as string;
            if (string.IsNullOrEmpty(username))
            {
                Response.Write("<script>alert('Session expired. Please log in again.');</script>");
            }
            else
            {
                Response.Redirect("EditProfile.aspx?username=" + username);
            }
        }

        protected void btnRenewSubscription_Click(object sender, EventArgs e)
        {
            string username = Session["Username"] as string;
            if (string.IsNullOrEmpty(username))
            {
                Response.Write("<script>alert('Session expired. Please log in again.');</script>");
            }
            else
            {
                Response.Redirect("RenewSubscription.aspx");
            }
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            string newPassword = newPasswordTextBox.Text.Trim();
            string confirmPassword = confirmPasswordTextBox.Text.Trim();
            string sessionUserID = Session["UserID"]?.ToString();

            if (string.IsNullOrEmpty(sessionUserID))
            {
                Response.Write("<script>alert('Session expired. Please log in again.');</script>");
                return;
            }

            if (newPassword != confirmPassword)
            {
                Response.Write("<script>alert('Passwords do not match!');</script>");
                return;
            }

            string plainPassword = newPassword;  // Store plain text password directly

            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["GymDB"].ConnectionString;
                using (MySqlConnection conn = new MySqlConnection(connStr))
                {
                    conn.Open();
                    string query = "UPDATE users SET Password = @Password WHERE UserID = @UserID";
                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Password", plainPassword);
                        cmd.Parameters.AddWithValue("@UserID", sessionUserID);

                        int rowsAffected = cmd.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            Response.Write("<script>alert('Password changed successfully!');</script>");
                        }
                        else
                        {
                            Response.Write("<script>alert('Error: Password not updated. Please try again.');</script>");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error changing password: " + ex.Message + "');</script>");
            }
        }


        protected void makepayment_Click(object sender, EventArgs e)
        {
           
                string username = Session["Username"]?.ToString();
                if (!string.IsNullOrEmpty(username))
                {
                    Response.Redirect("Payment.aspx");
                }
                else
                {
                    Session["RedirectUrl"] = "Payment.aspx";
                    Response.Redirect("Login.aspx");
                }
            

        }
    }
}
