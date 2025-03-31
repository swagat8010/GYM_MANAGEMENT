// EditTrainerProfile.aspx.cs
using System;
using System.Configuration;
using MySql.Data.MySqlClient;

namespace GYM_MANAGEMENT
{
    public partial class EditTrainerProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTrainerData();
            }
        }

        private void LoadTrainerData()
        {
            string trainerID = Session["TrainerID"]?.ToString();
            if (trainerID == null) Response.Redirect("Login.aspx");

            string connStr = ConfigurationManager.ConnectionStrings["GymDB"].ToString();
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT Name, Email, Specialization FROM Trainers WHERE TrainerID = @TrainerID";
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@TrainerID", trainerID);
                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            txtName.Text = reader["Name"].ToString();
                            txtEmail.Text = reader["Email"].ToString();
                            txtSpecialization.Text = reader["Specialization"].ToString();
                        }
                    }
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string trainerID = Session["TrainerID"]?.ToString();
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string specialization = txtSpecialization.Text.Trim();
            string password = txtPassword.Text.Trim();

            string connStr = ConfigurationManager.ConnectionStrings["GymDB"].ToString();
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string query = "UPDATE Trainers SET Name=@Name, Email=@Email, Specialization=@Specialization";
                if (!string.IsNullOrEmpty(password))
                {
                    query += ", Password=@Password";
                }
                query += " WHERE TrainerID=@TrainerID";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Specialization", specialization);
                    cmd.Parameters.AddWithValue("@TrainerID", trainerID);
                    if (!string.IsNullOrEmpty(password))
                    {
                        cmd.Parameters.AddWithValue("@Password", password);
                    }
                    cmd.ExecuteNonQuery();
                    lblMessage.Text = "Profile updated successfully!";
                }
            }
        }
    }
}
