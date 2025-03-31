using System;
using System.Data;
using MySql.Data.MySqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace GYM_MANAGEMENT
{
    public partial class MemberAttendance : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["GymDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtDate.Text = DateTime.Today.ToString("yyyy-MM-dd"); // Default to today's date
            }
        }

        protected void btnLoad_Click(object sender, EventArgs e)
        {
            LoadAttendance();
        }

        private void LoadAttendance()
        {
            using (MySqlConnection con = new MySqlConnection(connString))
            {
                string query = @"SELECT m.MemberID, m.Name, 
                                COALESCE(a.Status, 'Absent') AS Status 
                                FROM members m 
                                LEFT JOIN attendance a ON m.MemberID = a.MemberID AND a.Date = @Date";

                using (MySqlCommand cmd = new MySqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Date", txtDate.Text);
                    MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvAttendance.DataSource = dt;
                    gvAttendance.DataBind();
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            using (MySqlConnection con = new MySqlConnection(connString))
            {
                con.Open();
                foreach (GridViewRow row in gvAttendance.Rows)
                {
                    int memberId = Convert.ToInt32(row.Cells[0].Text);
                    DropDownList ddlStatus = (DropDownList)row.FindControl("ddlStatus");
                    string status = ddlStatus.SelectedValue;

                    string query = @"INSERT INTO attendance (MemberID, Date, Status) 
                                    VALUES (@MemberID, @Date, @Status) 
                                    ON DUPLICATE KEY UPDATE Status = @Status";

                    using (MySqlCommand cmd = new MySqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@MemberID", memberId);
                        cmd.Parameters.AddWithValue("@Date", txtDate.Text);
                        cmd.Parameters.AddWithValue("@Status", status);
                        cmd.ExecuteNonQuery();
                    }
                }
                con.Close();
            }
            LoadAttendance(); // Reload the data after saving
        }
    }
}
