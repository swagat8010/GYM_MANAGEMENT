using System;
using System.Data;
using MySql.Data.MySqlClient;
using System.Web.UI.WebControls;

namespace GYM_MANAGEMENT
{
    public partial class AssignTrainer : System.Web.UI.Page
    {
        private string connectionString = "server=localhost;database=gymmanagementdb;user=root;password=2004";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMembers();
                LoadTrainers();
            }
        }

        private void LoadMembers()
        {
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT MemberID, Name FROM members";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    ddlMembers.DataSource = dt;
                    ddlMembers.DataTextField = "Name";
                    ddlMembers.DataValueField = "MemberID";
                    ddlMembers.DataBind();
                }
            }
        }

        private void LoadTrainers()
        {
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT TrainerID, Name FROM trainers";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    ddlTrainers.DataSource = dt;
                    ddlTrainers.DataTextField = "Name";
                    ddlTrainers.DataValueField = "TrainerID";
                    ddlTrainers.DataBind();
                }
            }
        }

        protected void btnAssign_Click(object sender, EventArgs e)
        {
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    string query = "UPDATE members SET TrainerID = @TrainerID WHERE MemberID = @MemberID";

                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@TrainerID", ddlTrainers.SelectedValue);
                        cmd.Parameters.AddWithValue("@MemberID", ddlMembers.SelectedValue);

                        int rowsAffected = cmd.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            lblMessage.Text = "Trainer assigned successfully!";
                            lblMessage.ForeColor = System.Drawing.Color.Green;
                            Response.Write("<script>alert('Assigned Succesfull.');</script>");
                           
                            Response.Redirect("AdminDashboard.aspx");
                        }
                        else
                        {
                            lblMessage.Text = "Error: No member found!";
                            lblMessage.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error: " + ex.Message;
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
        }

    }
}
