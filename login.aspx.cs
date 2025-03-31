using System;
using MySql.Data.MySqlClient;
using System.Web.UI;
using System.Configuration;

namespace GYM_MANAGEMENT
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblMessage.Text = string.Empty; // Clear previous messages
        }

        protected void btnLogin_Click1(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            string connStr = ConfigurationManager.ConnectionStrings["GymDB"].ToString();

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                    string query = @"
                        SELECT u.UserID, u.Role, t.TrainerID 
                        FROM users u
                        LEFT JOIN Trainers t ON u.UserID = t.UserID
                        WHERE u.Username = @Username AND u.Password = @Password";

                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@Password", password);

                        using (MySqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read()) // If user found
                            {
                                string userID = reader["UserID"].ToString();
                                string role = reader["Role"].ToString();
                                string trainerID = reader["TrainerID"] != DBNull.Value ? reader["TrainerID"].ToString() : null;

                                // Store user details in session
                                Session["UserID"] = userID;
                                Session["Username"] = username;
                                Session["Role"] = role;

                                if (role == "Trainer" && trainerID != null)
                                {
                                    Session["TrainerID"] = trainerID;
                                }

                                // **Strict Role-Based Redirection**
                                switch (role)
                                {
                                    case "Admin":
                                        Response.Redirect("AdminDashboard.aspx", false);
                                        break;
                                    case "Trainer":
                                        Response.Redirect("TrainerDashboard.aspx", false);
                                        break;
                                    case "Member":
                                        Response.Redirect("Dashboard.aspx", false);
                                        break;
                                    default:
                                        lblMessage.Text = "Unauthorized role.";
                                        break;
                                }
                            }
                            else
                            {
                                lblMessage.Text = "Invalid username or password!";
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "An error occurred during login. Please try again.";
                }
            }
        }
    }
}
