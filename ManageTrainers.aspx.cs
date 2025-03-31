using System;
using System.Configuration;
using System.Data;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace GYM_MANAGEMENT
{
    public partial class ManageTrainers : System.Web.UI.Page
    {
        private string connectionString = "server=localhost;database=gymmanagementdb;user=root;password=2004";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindTrainerGrid();
            }
        }

        private void BindTrainerGrid()
        {
            string query = "SELECT TrainerID, Name, Email, Specialization, JoinDate FROM trainers";
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                MySqlDataAdapter adapter = new MySqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                gvTrainers.DataSource = dt;
                gvTrainers.DataBind();
            }
        }

        protected void gvTrainers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvTrainers.EditIndex = e.NewEditIndex;
            BindTrainerGrid();
        }

        protected void gvTrainers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvTrainers.EditIndex = -1;
            BindTrainerGrid();
        }

        protected void gvTrainers_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int trainerId = Convert.ToInt32(gvTrainers.DataKeys[e.RowIndex].Value);

                TextBox txtName = (TextBox)gvTrainers.Rows[e.RowIndex].FindControl("txtName");
                TextBox txtEmail = (TextBox)gvTrainers.Rows[e.RowIndex].FindControl("txtEmail");
                TextBox txtSpecialization = (TextBox)gvTrainers.Rows[e.RowIndex].FindControl("txtSpecialization");
                TextBox txtJoinDate = (TextBox)gvTrainers.Rows[e.RowIndex].FindControl("txtJoinDate");

                if (txtName == null || txtEmail == null || txtSpecialization == null || txtJoinDate == null)
                {
                    lblError.Text = "Error: Missing input fields.";
                    lblError.Visible = true;
                    return;
                }

                string name = txtName.Text.Trim();
                string email = txtEmail.Text.Trim();
                string specialization = txtSpecialization.Text.Trim();
                string joinDateStr = txtJoinDate.Text.Trim();

                if (!DateTime.TryParseExact(joinDateStr, "dd-MM-yyyy", null, System.Globalization.DateTimeStyles.None, out DateTime joinDate))
                {
                    lblError.Text = "Invalid date format. Use DD-MM-YYYY.";
                    lblError.Visible = true;
                    return;
                }

                string query = "UPDATE trainers SET Name = @Name, Email = @Email, Specialization = @Specialization, JoinDate = @JoinDate WHERE TrainerID = @TrainerID";

                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Specialization", specialization);
                    cmd.Parameters.AddWithValue("@JoinDate", joinDate.ToString("yyyy-MM-dd"));
                    cmd.Parameters.AddWithValue("@TrainerID", trainerId);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                gvTrainers.EditIndex = -1;
                BindTrainerGrid();
            }
            catch (Exception ex)
            {
                lblError.Text = "Error: " + ex.Message;
                lblError.Visible = true;
            }
        }

        protected void gvTrainers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int trainerId = Convert.ToInt32(gvTrainers.DataKeys[e.RowIndex].Value);

                string query = "DELETE FROM trainers WHERE TrainerID = @TrainerID";
                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@TrainerID", trainerId);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                BindTrainerGrid();
            }
            catch (Exception ex)
            {
                lblError.Text = "Error: " + ex.Message;
                lblError.Visible = true;
            }
        }
    }
}
