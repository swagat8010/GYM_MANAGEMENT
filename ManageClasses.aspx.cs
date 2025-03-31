using System;
using System.Data;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace GYM_MANAGEMENT
{
    public partial class ManageClasses : System.Web.UI.Page
    {
        string connString = "server=localhost;user id=root;password=2004;database=gymmanagementdb";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTrainers();
                BindClassGrid();
            }
        }

        private void LoadTrainers()
        {
            using (MySqlConnection conn = new MySqlConnection(connString))
            {
                string query = "SELECT TrainerID, Name FROM trainers";
                MySqlDataAdapter da = new MySqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlTrainers.DataSource = dt;
                ddlTrainers.DataTextField = "Name";
                ddlTrainers.DataValueField = "TrainerID";
                ddlTrainers.DataBind();

                ddlTrainers.Items.Insert(0, new ListItem("--Select Trainer--", ""));
            }
        }

        private void BindClassGrid()
        {
            using (MySqlConnection conn = new MySqlConnection(connString))
            {
                string query = "SELECT ClassID, ClassName, Trainer, Schedule, ClassTime FROM classes";
                MySqlDataAdapter da = new MySqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvClasses.DataSource = dt;
                gvClasses.DataBind();
            }
        }

        protected void btnAddClass_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtClassName.Text) || string.IsNullOrEmpty(txtSchedule.Text) || string.IsNullOrEmpty(txtClassTime.Text) || ddlTrainers.SelectedIndex == 0)
            {
                lblMessage.Text = "All fields are required!";
                return;
            }

            using (MySqlConnection conn = new MySqlConnection(connString))
            {
                string query = "INSERT INTO classes (ClassName, Trainer, Schedule, ClassTime) VALUES (@ClassName, @Trainer, @Schedule, @ClassTime)";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@ClassName", txtClassName.Text);
                cmd.Parameters.AddWithValue("@Trainer", ddlTrainers.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@Schedule", txtSchedule.Text);
                cmd.Parameters.AddWithValue("@ClassTime", txtClassTime.Text);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                lblMessage.Text = "Class added successfully!";
                BindClassGrid();
            }
        }

        protected void gvClasses_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int classID = Convert.ToInt32(gvClasses.DataKeys[e.RowIndex].Value);

            using (MySqlConnection conn = new MySqlConnection(connString))
            {
                string query = "DELETE FROM classes WHERE ClassID = @ClassID";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@ClassID", classID);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                BindClassGrid();
            }
        }

        protected void gvClasses_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvClasses.EditIndex = e.NewEditIndex;
            BindClassGrid();
        }
    }
}
