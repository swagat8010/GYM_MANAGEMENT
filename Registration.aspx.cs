using System;
using System.Web.UI;
using MySql.Data.MySqlClient;

namespace GYM_MANAGEMENT
{
    public partial class Registration : System.Web.UI.Page
    {
        string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["GymDB"].ToString();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSubscriptionPlans();
            }
        }

        private void LoadSubscriptionPlans()
        {
            try
            {
                using (MySqlConnection conn = new MySqlConnection(connStr))
                {
                    conn.Open();
                    string query = "SELECT SubscriptionID, PlanName, DurationMonths FROM subscriptions WHERE IsActive = 1";
                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    MySqlDataReader reader = cmd.ExecuteReader();

                    ddlSubscriptionPlan.DataSource = reader;
                    ddlSubscriptionPlan.DataTextField = "PlanName";
                    ddlSubscriptionPlan.DataValueField = "SubscriptionID";
                    ddlSubscriptionPlan.DataBind();
                    ddlSubscriptionPlan.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select Plan", ""));
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error loading subscription plans: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            // Validate required fields
            if (string.IsNullOrEmpty(txtFirstName.Text.Trim()) ||
                string.IsNullOrEmpty(txtLastName.Text.Trim()) ||
                string.IsNullOrEmpty(txtEmail.Text.Trim()) ||
                string.IsNullOrEmpty(txtPhone.Text.Trim()) ||
                string.IsNullOrEmpty(ddlSubscriptionPlan.SelectedValue) ||
                ddlSubscriptionPlan.SelectedValue == "" ||
                !chkTerms.Checked)
            {
                lblMessage.Text = "Please fill all required fields and agree to terms";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string fullName = $"{firstName} {lastName}";
            string email = txtEmail.Text.Trim();
            string phone = txtPhone.Text.Trim();
            int subscriptionID = int.Parse(ddlSubscriptionPlan.SelectedValue);

            // Get UserID from query string or session
            if (!int.TryParse(Request.QueryString["UserID"] ?? Session["UserID"]?.ToString(), out int userID) || userID == 0)
            {
                lblMessage.Text = "Invalid User ID";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            try
            {
                // Check if email already exists
                if (EmailExists(email))
                {
                    lblMessage.Text = "Email address already registered";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                DateTime joinDate = DateTime.Now;
                DateTime endDate = CalculateEndDate(subscriptionID);
                decimal amount = GetSubscriptionAmount(subscriptionID);

                using (MySqlConnection conn = new MySqlConnection(connStr))
                {
                    conn.Open();

                    // Insert into members table - CORRECTED to match your table structure
                    string insertMemberQuery = @"INSERT INTO members 
                                      (UserID, Name, Email, Phone, JoinDate, EndDate, SubscriptionPlan, SubscriptionID, TrainerID) 
                                      VALUES 
                                      (@UserID, @Name, @Email, @Phone, @JoinDate, @EndDate, @SubscriptionPlan, @SubscriptionID, @TrainerID)";

                    MySqlCommand cmd = new MySqlCommand(insertMemberQuery, conn);
                    cmd.Parameters.AddWithValue("@UserID", userID);
                    cmd.Parameters.AddWithValue("@Name", fullName);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Phone", phone);
                    cmd.Parameters.AddWithValue("@JoinDate", joinDate);
                    cmd.Parameters.AddWithValue("@EndDate", endDate);
                    cmd.Parameters.AddWithValue("@SubscriptionPlan", ddlSubscriptionPlan.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@SubscriptionID", subscriptionID);
                    cmd.Parameters.AddWithValue("@TrainerID", DBNull.Value); // Set as NULL initially

                    cmd.ExecuteNonQuery();

                    // Get inserted MemberID
                    long memberID = cmd.LastInsertedId;

                    // Insert payment record
                    string paymentQuery = @"INSERT INTO payments 
                                   (MemberID, Name, Amount, PaymentDate, PaymentMethod, ReferenceCode) 
                                   VALUES 
                                   (@MemberID, @Name, @Amount, NOW(), 'pending', 'pending')";

                    MySqlCommand paymentCmd = new MySqlCommand(paymentQuery, conn);
                    paymentCmd.Parameters.AddWithValue("@MemberID", memberID);
                    paymentCmd.Parameters.AddWithValue("@Name", fullName);
                    paymentCmd.Parameters.AddWithValue("@Amount", amount);
                    paymentCmd.ExecuteNonQuery();

                    lblMessage.Text = "Registration successful!";
                    lblMessage.ForeColor = System.Drawing.Color.Green;

                    // Redirect after delay
                    ScriptManager.RegisterStartupScript(this, GetType(), "redirect",
                        "setTimeout(function(){ window.location.href = 'login.aspx'; }, 2000);", true);
                }
            }
            catch (MySqlException ex)
            {
                lblMessage.Text = "Database error: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
                System.Diagnostics.Debug.WriteLine("SQL Error: " + ex.ToString());
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error during registration: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
                System.Diagnostics.Debug.WriteLine("Error: " + ex.ToString());
            }
        }

        private bool EmailExists(string email)
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT COUNT(*) FROM members WHERE Email = @Email";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", email);
                return Convert.ToInt32(cmd.ExecuteScalar()) > 0;
            }
        }

        private DateTime CalculateEndDate(int subscriptionID)
        {
            int duration = GetSubscriptionDuration(subscriptionID);
            return DateTime.Now.AddMonths(duration);
        }

        private int GetSubscriptionDuration(int subscriptionID)
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT DurationMonths FROM subscriptions WHERE SubscriptionID = @SubscriptionID";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@SubscriptionID", subscriptionID);
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

        private decimal GetSubscriptionAmount(int subscriptionID)
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT Price FROM subscriptions WHERE SubscriptionID = @SubscriptionID";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@SubscriptionID", subscriptionID);
                return Convert.ToDecimal(cmd.ExecuteScalar());
            }
        }
    }
}