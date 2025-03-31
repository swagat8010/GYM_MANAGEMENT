using System;
using System.Data;
using MySql.Data.MySqlClient;
using System.Configuration;
using System.Web.UI;

namespace GYM_MANAGEMENT
{
    public partial class TrainerDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["Role"].ToString() != "Trainer")
            {
                Response.Redirect("Login.aspx");
            }
            if (!IsPostBack)
            {
                if (Session["TrainerID"] != null)
                {
                    LoadTrainerDetails();
                    LoadAssignedMembers();
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        private void LoadTrainerDetails()
        {
            string trainerID = Session["TrainerID"].ToString();
            string connStr = ConfigurationManager.ConnectionStrings["GymDB"].ConnectionString;

            using (MySqlConnection con = new MySqlConnection(connStr))
            {
                string query = "SELECT Name, Email, Specialization FROM Trainers WHERE TrainerID = @TrainerID";
                using (MySqlCommand cmd = new MySqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@TrainerID", trainerID);
                    con.Open();
                    MySqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        lblTrainerName.Text = reader["Name"].ToString();
                        lblTrainerEmail.Text = reader["Email"].ToString();
                        lblTrainerSpecialization.Text = reader["Specialization"].ToString();
                    }
                }
            }
        }

        private void LoadAssignedMembers()
        {
            string trainerID = Session["TrainerID"].ToString();
            string connStr = ConfigurationManager.ConnectionStrings["GymDB"].ConnectionString;

            using (MySqlConnection con = new MySqlConnection(connStr))
            {
                string query = @"
                    SELECT m.Name AS MemberName, s.PlanName AS SubscriptionPlan, 
                    (SELECT CAST(COUNT(*) * 100.0 / 30 AS SIGNED) 
                     FROM Attendance a WHERE a.MemberID = m.MemberID AND a.Status = 'Present' 
                     AND a.Date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)) AS AttendancePercentage
                    FROM Members m
                    INNER JOIN Subscriptions s ON m.SubscriptionID = s.SubscriptionID
                    WHERE m.TrainerID = @TrainerID";

                using (MySqlCommand cmd = new MySqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@TrainerID", trainerID);
                    con.Open();
                    MySqlDataReader reader = cmd.ExecuteReader();

                    DataTable dt = new DataTable();
                    dt.Load(reader);

                    rptMembers.DataSource = dt;
                    rptMembers.DataBind();
                }
            }
        }
    }
}
