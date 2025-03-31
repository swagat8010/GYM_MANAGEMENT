using MySql.Data.MySqlClient;
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GYM_MANAGEMENT
{
    public partial class Classes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadClasses();
            }
        }

        private void LoadClasses()
        {
            string connString = "server=localhost; database=gymmanagementdb; uid=root; pwd=2004;";

            using (MySqlConnection conn = new MySqlConnection(connString))
            {
                try
                {
                    conn.Open();

                    string query = @"
                SELECT ClassID, ClassName, Instructor, Trainer, 
                DATE_FORMAT(ClassTime, '%h:%i %p') AS ClassTime, 
                IFNULL(Schedule, 'TBD') AS Schedule 
                FROM classes";

                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    rptClasses.DataSource = dt;
                    rptClasses.DataBind();
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error: " + ex.Message.Replace("'", "\\'") + "');</script>");
                }
            }
        }

    }
}
