using System;
using MySql.Data.MySqlClient;

namespace GYM_MANAGEMENT
{
    public partial class SignUp : System.Web.UI.Page
    {
        string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["GymDB"].ToString();

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSignUp_Click1(object sender, EventArgs e)
        {
            // Retrieve form values
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();
            string role = ddlRole.SelectedValue;
            

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                Response.Write("<script>alert('Please fill all the fields.');</script>");
                return;
            }

            try
            {
                using (MySqlConnection conn = new MySqlConnection(connStr))
                {
                    conn.Open();

                    // Insert user into 'users' table
                    string query = "INSERT INTO users (Username, Password, Role) VALUES (@Username, @Password, @Role)";
                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Password", password);
                    cmd.Parameters.AddWithValue("@Role", role);
                    cmd.ExecuteNonQuery();

                    // Get the UserID of the newly inserted user
                    cmd.CommandText = "SELECT LAST_INSERT_ID()";
                    int userId = Convert.ToInt32(cmd.ExecuteScalar());
                    if(role== "Admin")
                    {
                      Response.Redirect("login.aspx?UserID=" + userId);

                    }
                    if (role == "Member")
                    {
                        Response.Redirect("Registration.aspx?UserID=" + userId);

                    }
                    if (role == "Trainer")
                    {
                        Response.Redirect("TrainerDashboard.aspx?UserID=" + userId);

                    }
                    // Redirect to Registration page with UserID as a query string
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }

    }
}
