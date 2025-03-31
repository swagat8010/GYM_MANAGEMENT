using MySql.Data.MySqlClient;
using System;
using System.Web.UI;

namespace GYM_MANAGEMENT
{
    public partial class EditProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string username = Request.QueryString["username"];

                // Redirect if the username is missing or invalid
                if (string.IsNullOrEmpty(username))
                {
                    Response.Redirect("Dashboard.aspx");
                }
                else
                {
                    LoadUserProfile(username);
                }
            }
        }

        private void LoadUserProfile(string username)
        {
            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["GymDB"].ToString();
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                string query = "SELECT u.Username, m.Email, m.Name, m.Phone  " +
                               "FROM users u " +
                               "INNER JOIN members m ON u.UserID = m.UserID " +
                               "WHERE u.Username = @Username";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Username", username);
                    conn.Open();
                    MySqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        txtUsername.Text = reader["Username"].ToString();
                        txtEmail.Text = reader["Email"].ToString();
                        txtName.Text = reader["Name"].ToString();
                        txtPhone.Text = reader["Phone"].ToString();
                    }
                    else
                    {
                        // If no matching user found, redirect to dashboard or login
                        Response.Redirect("Dashboard.aspx");
                    }
                }
            }
        }


        private void UpdateUserProfile(string username)
        {
            Response.Write("<script>alert('Inside UpdateUserProfile!');</script>");

            try
            {
                Response.Write("<script>alert('Inside try block!');</script>");

                // Check if username is null or empty
                if (string.IsNullOrEmpty(username))
                {
                    Response.Write("<script>alert('Username is NULL or EMPTY!');</script>");
                    return;
                }

                // Check if connection string is null or empty
                string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["GymDB"]?.ToString();
                if (string.IsNullOrEmpty(connStr))
                {
                    Response.Write("<script>alert('Connection string is NULL or EMPTY!');</script>");
                    return;
                }

                Response.Write("<script>alert('Connection string is valid! Preparing to connect to DB...');</script>");

                using (MySqlConnection conn = new MySqlConnection(connStr))
                {
                    try
                    {
                        conn.Open();
                        Response.Write("<script>alert('Connected to DB!');</script>");

                        string query = "UPDATE members m " +
                                       "JOIN users u ON m.UserID = u.UserID " +
                                       "SET m.Email = @Email, m.Name = @Name, m.Phone = @Phone " +
                                       "WHERE u.Username = @Username";

                        using (MySqlCommand cmd = new MySqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@Username", username);
                            cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                            cmd.Parameters.AddWithValue("@Name", txtName.Text);
                            cmd.Parameters.AddWithValue("@Phone", txtPhone.Text);

                            Response.Write("<script>alert('Executing query...');</script>");
                            int rowsAffected = cmd.ExecuteNonQuery();

                            if (rowsAffected > 0)
                            {
                                Response.Write("<script>alert('Profile updated successfully!'); window.location='Dashboard.aspx?username=" + username + "';</script>");
                            }
                            else
                            {
                                Response.Write("<script>alert('No records updated. Please check inputs!');</script>");
                            }
                        }
                    }
                    catch (MySql.Data.MySqlClient.MySqlException ex)
                    {
                        Response.Write("<script>alert('MySQL Connection Error: " + ex.Message + "');</script>");
                    }
                }
            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {
                Response.Write("<script>alert('MySQL Error: " + ex.Message + "');</script>");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('General Error: " + ex.Message + "');</script>");
            }
        }





        protected void btnSaveChanges_Click1(object sender, EventArgs e)
        {
            try
            {
                Response.Write("<script>alert('Button Clicked!');</script>");
                string username = Request.QueryString["username"];

                // Validate inputs
                if (string.IsNullOrEmpty(txtEmail.Text) || string.IsNullOrEmpty(txtName.Text))
                {
                    Response.Write("<script>alert('Please fill all the fields.');</script>");
                    return;
                }

                // Log the input values for debugging
                Response.Write("<script>alert('Username: " + username + "\\nEmail: " + txtEmail.Text + "\\nName: " + txtName.Text + "');</script>");

                // Call update method
                UpdateUserProfile(username);

                // Log if update was called
                Response.Write("<script>alert('UpdateUserProfile called!');</script>");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error in btnSaveChanges_Click1: " + ex.Message + "');</script>");
            }
        }
    

    }
}
