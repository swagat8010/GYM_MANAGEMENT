using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GYM_MANAGEMENT
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        { 
            if (!IsPostBack)
            {
                BindTotalCounts();
                BindGridViews();
            }
            if (Session["Role"] == null || Session["Role"].ToString() != "Admin")
            {
                // Redirect to login if not authenticated as Admin
                Response.Redirect("login.aspx");
            }
           
        }

        private void BindTotalCounts()
        {
            lblTotalMembers.Text = GetTotalCount("SELECT COUNT(*) FROM members").ToString();
            lblTotalTrainers.Text = GetTotalCount("SELECT COUNT(*) FROM trainers").ToString();

            // Active subscriptions based on the IsActive column
            lblActiveSubscriptions.Text = GetTotalCount("SELECT COUNT(*) FROM subscriptions WHERE IsActive = 1").ToString();

            // Pending payments query (PaymentDate is NULL)
            lblPendingPayments.Text = GetTotalCount("SELECT COUNT(*) FROM payments WHERE PaymentMethod = 'Pending'").ToString();
        }



        private void BindGridViews()
        {
            gvMembers.DataSource = GetDataTable("SELECT * FROM members");
            gvMembers.DataBind();

            gvSubscriptions.DataSource = GetDataTable("SELECT * FROM subscriptions");
            gvSubscriptions.DataBind();

            gvPayments.DataSource = GetDataTable("SELECT * FROM payments");
            gvPayments.DataBind();
        }

        private int GetTotalCount(string query)
        {
            int count = 0;
            string connectionString = "server=localhost;database=gymmanagementdb;user=root;password=2004";

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                MySqlCommand cmd = new MySqlCommand(query, conn);
                count = Convert.ToInt32(cmd.ExecuteScalar());
            }

            return count;
        }

        private DataTable GetDataTable(string query)
        {
            DataTable dt = new DataTable();
            string connectionString = "server=localhost;database=gymmanagementdb;user=root;password=2004";

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                MySqlDataAdapter da = new MySqlDataAdapter(query, conn);
                da.Fill(dt);
            }

            return dt;
        }
    }
}
    
