using MySql.Data.MySqlClient;
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GYM_MANAGEMENT
{
    public partial class ManageMembers : System.Web.UI.Page
    {
        private string connectionString = "server=localhost;database=gymmanagementdb;user=root;password=2004";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindMembersGrid();
            }
        }

        private void BindMembersGrid()
        {
            string query = "SELECT * FROM members";
            gvMembers.DataSource = GetDataTable(query);
            gvMembers.DataBind();
        }

        private DataTable GetDataTable(string query)
        {
            DataTable dt = new DataTable();
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                MySqlDataAdapter da = new MySqlDataAdapter(query, conn);
                da.Fill(dt);
            }
            return dt;
        }

        protected void gvMembers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvMembers.EditIndex = e.NewEditIndex;
            BindMembersGrid();
        }

        protected void gvMembers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvMembers.EditIndex = -1;
            BindMembersGrid();
        }

        protected void gvMembers_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int memberId = Convert.ToInt32(gvMembers.DataKeys[e.RowIndex].Value);

            string name = ((TextBox)gvMembers.Rows[e.RowIndex].FindControl("txtName")).Text;
            string email = ((TextBox)gvMembers.Rows[e.RowIndex].FindControl("txtEmail")).Text;
            string phone = ((TextBox)gvMembers.Rows[e.RowIndex].FindControl("txtPhone")).Text;
            string subscriptionPlan = ((TextBox)gvMembers.Rows[e.RowIndex].FindControl("txtSubscriptionPlan")).Text;

            string query = "UPDATE members SET Name=@Name, Email=@Email, Phone=@Phone, SubscriptionPlan=@SubscriptionPlan WHERE MemberID=@MemberID";

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Phone", phone);
                    cmd.Parameters.AddWithValue("@SubscriptionPlan", subscriptionPlan);
                    cmd.Parameters.AddWithValue("@MemberID", memberId);
                    cmd.ExecuteNonQuery();
                }
            }

            gvMembers.EditIndex = -1;
            BindMembersGrid();
        }

        protected void gvMembers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int memberId = Convert.ToInt32(gvMembers.DataKeys[e.RowIndex].Value);

            string query = "DELETE FROM members WHERE MemberID=@MemberID";

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@MemberID", memberId);
                    cmd.ExecuteNonQuery();
                }
            }

            BindMembersGrid();
        }

        // Add pagination handler
        protected void gvMembers_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvMembers.PageIndex = e.NewPageIndex;
            BindMembersGrid();
        }

        // Add sorting handler
        protected void gvMembers_Sorting(object sender, GridViewSortEventArgs e)
        {
            DataTable dt = GetDataTable("SELECT * FROM members");
            DataView dv = dt.DefaultView;
            dv.Sort = e.SortExpression + " " + (ViewState["SortDirection"]?.ToString() == "ASC" ? "DESC" : "ASC");
            ViewState["SortDirection"] = (ViewState["SortDirection"]?.ToString() == "ASC" ? "DESC" : "ASC");
            gvMembers.DataSource = dv;
            gvMembers.DataBind();
        }
    }
}
