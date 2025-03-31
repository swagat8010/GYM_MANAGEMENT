using System;
using System.Configuration;
using MySql.Data.MySqlClient;

namespace GYM_MANAGEMENT
{
    public partial class TrainerSignup : System.Web.UI.Page
    {
        protected void btnSignup_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string specialization = txtSpecialization.Text.Trim();
            string joinDate = DateTime.Now.ToString("yyyy-MM-dd"); // Current date

            string connStr = ConfigurationManager.ConnectionStrings["GymDB"].ConnectionString;
            using (MySqlConnection con = new MySqlConnection(connStr))
            {
                con.Open();
                MySqlTransaction transaction = con.BeginTransaction();

                try
                {
                    // 1️⃣ Insert into `users` table FIRST
                    string insertUserQuery = "INSERT INTO users (Username, Password, Role) VALUES (@Username, @Password, 'Trainer')";
                    MySqlCommand insertUserCmd = new MySqlCommand(insertUserQuery, con, transaction);
                    insertUserCmd.Parameters.AddWithValue("@Username", username);
                    insertUserCmd.Parameters.AddWithValue("@Password", password);
                    insertUserCmd.ExecuteNonQuery();

                    // 2️⃣ Get the newly inserted UserID
                    int userID = (int)insertUserCmd.LastInsertedId;

                    // 3️⃣ Insert into `trainers` table using the UserID
                    string insertTrainerQuery = "INSERT INTO trainers (Name, Email, Phone, JoinDate, Specialization, UserID) VALUES (@Name, @Email, @Phone, @JoinDate, @Specialization, @UserID)";
                    MySqlCommand insertTrainerCmd = new MySqlCommand(insertTrainerQuery, con, transaction);
                    insertTrainerCmd.Parameters.AddWithValue("@Name", name);
                    insertTrainerCmd.Parameters.AddWithValue("@Email", email);
                    insertTrainerCmd.Parameters.AddWithValue("@Phone", phone);
                    insertTrainerCmd.Parameters.AddWithValue("@JoinDate", joinDate);
                    insertTrainerCmd.Parameters.AddWithValue("@Specialization", specialization);
                    insertTrainerCmd.Parameters.AddWithValue("@UserID", userID);
                    insertTrainerCmd.ExecuteNonQuery();

                    // ✅ Commit the transaction
                    transaction.Commit();

                    lblMessage.Text = "Trainer registered successfully!";
                    Response.Redirect("login.aspx");
                }
                catch (Exception ex)
                {
                    // ❌ Rollback in case of error
                    transaction.Rollback();
                    lblMessage.Text = "Error: " + ex.Message;
                }
            }
        }

    }
}
