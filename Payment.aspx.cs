using MySql.Data.MySqlClient;
using System;
using System.Xml.Linq;

namespace GYM_MANAGEMENT
{
    public partial class Payment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Username"] == null)
                {
                    // Save the intended URL before redirecting to login
                    Session["RedirectUrl"] = "Payment.aspx";
                    Response.Redirect("Login.aspx");
                }
                else
                {
                    string username = Session["Username"].ToString();
                    LoadPaymentDetails(username);
                }
            }
        }

        // Method to load payment details based on username
        private void LoadPaymentDetails(string username)
        {
            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["GymDB"].ToString();
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                // Use JOIN instead of subquery to prevent errors
                string query = @"SELECT m.Email, m.Name, s.PlanName, s.Price 
                         FROM members m
                         INNER JOIN subscriptions s ON m.SubscriptionID = s.SubscriptionID
                         INNER JOIN users u ON m.UserID = u.UserID
                         WHERE u.Username = @Username
                         LIMIT 1";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Username", username);
                    conn.Open();
                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            string name = reader["Name"].ToString();
                            string planName = reader["PlanName"].ToString();
                            string price = reader["Price"].ToString();

                            lblSubscription.Text = "Subscription Plan: " + planName;
                            lblAmount.Text = "Amount: ₹" + price;
                            txtName.Text = name;  // Set name in textbox
                            ViewState["Amount"] = price;  // Store amount for payment processing
                        }
                        else
                        {
                            lblMessage.Text = "No subscription found!";
                        }
                    }
                }
            }
        }

        // Method to handle payment processing
        protected void btnPayNow_Click(object sender, EventArgs e)
        {
            string username = Session["Username"].ToString();  // Get username from session
            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["GymDB"].ToString();

            if (ViewState["Amount"] != null)
            {
                string amount = ViewState["Amount"].ToString();
                string name = txtName.Text;
                string paymentMethod = ddlPaymentMethod.SelectedValue;  // Assume dropdown for payment method
                string referenceCode = txtReferenceCode.Text;  // Assume textbox for reference code

                using (MySqlConnection conn = new MySqlConnection(connStr))
                {
                    // Use JOIN instead of subquery to prevent multiple rows issue
                    string query = @"INSERT INTO payments (MemberID, Name, Amount, PaymentDate, PaymentMethod, ReferenceCode)
                             SELECT m.MemberID, @Name, @Amount, NOW(), @PaymentMethod, @ReferenceCode
                             FROM members m
                             INNER JOIN users u ON m.UserID = u.UserID
                             WHERE u.Username = @Username
                             LIMIT 1;";

                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    {
                        // Add parameters to prevent SQL injection
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@Amount", amount);
                        cmd.Parameters.AddWithValue("@PaymentMethod", paymentMethod);
                        cmd.Parameters.AddWithValue("@ReferenceCode", referenceCode);

                        conn.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            string message = "Payment successful!";
                            string redirectUrl = "Dashboard.aspx?username=" + username;

                            // JavaScript for alert and redirect
                            string script = $"<script>alert('{message}'); window.location='{redirectUrl}';</script>";
                            ClientScript.RegisterStartupScript(this.GetType(), "Redirect", script);
                        }
                        else
                        {
                            lblMessage.Text = "Payment failed. Please try again.";
                        }
                    }
                }
            }
            else
            {
                lblMessage.Text = "Payment failed. Please try again.";
            }
        }

    }
}
