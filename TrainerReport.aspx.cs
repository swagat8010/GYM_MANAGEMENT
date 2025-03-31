using System;
using System.Configuration;
using System.Data;
using MySql.Data.MySqlClient;

namespace GYM_MANAGEMENT
{
    public partial class TrainerReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAttendanceReport();
            }
        }

        private void LoadAttendanceReport()
        {
            // Get TrainerID from session
            string trainerID = Session["TrainerID"]?.ToString();
            if (string.IsNullOrEmpty(trainerID))
            {
                Response.Redirect("Login.aspx"); // Redirect if not logged in
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["GymDB"].ToString();

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string query = @"
    SELECT 
        m.Name AS MemberName, 
        a.Date, 
        a.Status AS AttendanceStatus, 
        CASE 
            WHEN p.PaymentID IS NOT NULL THEN 'Paid'
            ELSE 'Pending'
        END AS PaymentStatus
    FROM attendance a
    JOIN members m ON a.MemberID = m.MemberID
    LEFT JOIN payments p ON m.MemberID = p.MemberID
    WHERE m.TrainerID = @TrainerID
    ORDER BY a.Date DESC;";


                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@TrainerID", trainerID);
                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        DataTable dt = new DataTable();
                        dt.Load(reader);

                        // Bind data to GridView
                        GridViewAttendance.DataSource = dt;
                        GridViewAttendance.DataBind();
                    }
                }
            }
        }
    }
}
