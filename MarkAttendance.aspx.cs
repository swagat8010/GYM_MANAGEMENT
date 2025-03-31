using System;
using MySql.Data.MySqlClient;
using System.Web.UI;

namespace GYM_MANAGEMENT
{
    public partial class MarkAttendance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("login.aspx"); // Redirect if not logged in
            }
        }

        protected void btnSubmitAttendance_Click(object sender, EventArgs e)
        {
            Button1.Visible = true;
            string userID = Session["UserID"]?.ToString(); // Ensure UserID is available
            if (string.IsNullOrEmpty(userID))
            {
                lblMessage.Text = "User not logged in.";
                return;
            }

            string connectionString = "server=localhost;database=gymmanagementdb;user=root;password=2004";

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    // Get MemberID from the members table using UserID
                    string getMemberIDQuery = "SELECT MemberID FROM members WHERE UserID = @UserID";
                    MySqlCommand getMemberCmd = new MySqlCommand(getMemberIDQuery, conn);
                    getMemberCmd.Parameters.AddWithValue("@UserID", userID);
                    object memberID = getMemberCmd.ExecuteScalar();

                    if (memberID == null)
                    {
                        lblMessage.Text = "Error: Member record not found.";
                        return;
                    }

                    // Check if attendance is already marked for today
                    string checkAttendanceQuery = "SELECT COUNT(*) FROM attendance WHERE MemberID = @MemberID AND DATE(Date) = CURDATE()";
                    MySqlCommand checkCmd = new MySqlCommand(checkAttendanceQuery, conn);
                    checkCmd.Parameters.AddWithValue("@MemberID", memberID);
                    int count = Convert.ToInt32(checkCmd.ExecuteScalar());

                    if (count > 0)
                    {
                        lblMessage.Text = "Attendance already marked for today!";
                        Button1.Visible = true;
                        return;
                    }

                    // Insert attendance with current date and time
                    string insertQuery = "INSERT INTO attendance (MemberID, Date, Status) VALUES (@MemberID, NOW(), 'Present')";
                    MySqlCommand insertCmd = new MySqlCommand(insertQuery, conn);
                    insertCmd.Parameters.AddWithValue("@MemberID", memberID);

                    int rowsAffected = insertCmd.ExecuteNonQuery();
                    lblMessage.Text = rowsAffected > 0 ? "Attendance marked successfully!" : "Failed to mark attendance.";
                    Button1.Visible = true;
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error: " + ex.Message;
                }
            }
        }

        protected void RedirectToDashboard(object sender, EventArgs e)
        {
            Response.Redirect("Dashboard.aspx");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }
    }
}
