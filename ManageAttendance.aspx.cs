using System;
using System.Data;
using MySql.Data.MySqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using OfficeOpenXml;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.IO;
using System.Web;

namespace GYM_MANAGEMENT
{
    public partial class ManageAttendance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["TrainerID"] == null || string.IsNullOrEmpty(Session["TrainerID"].ToString()))
                {
                    Response.Redirect("Login.aspx");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("TrainerID: " + Session["TrainerID"]);
                    LoadAttendance();
                }
            }
        }

        private void LoadAttendance()
        {
            string trainerID = Session["TrainerID"].ToString();
            string connStr = ConfigurationManager.ConnectionStrings["GymDB"].ConnectionString;

            using (MySqlConnection con = new MySqlConnection(connStr))
            {
                string query = @"SELECT m.Name AS MemberName, a.Date, a.Status 
                                FROM Attendance a
                                INNER JOIN Members m ON a.MemberID = m.MemberID
                                WHERE m.TrainerID = @TrainerID
                                ORDER BY a.Date DESC";

                using (MySqlCommand cmd = new MySqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@TrainerID", trainerID);
                    try
                    {
                        con.Open();
                        MySqlDataReader reader = cmd.ExecuteReader();
                        DataTable dt = new DataTable();
                        dt.Load(reader);

                        System.Diagnostics.Debug.WriteLine("Rows Retrieved: " + dt.Rows.Count);

                        rptAttendance.DataSource = dt;
                        rptAttendance.DataBind();
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine("Database Error: " + ex.Message);
                        Response.Write("<script>alert('Database Error: " + ex.Message + "');</script>");
                    }
                }
            }
        }

        protected void btnExportExcel_Click(object sender, EventArgs e)
        {
            DataTable dt = GetAttendanceData();
            using (ExcelPackage pck = new ExcelPackage())
            {
                ExcelWorksheet ws = pck.Workbook.Worksheets.Add("Attendance Report");
                ws.Cells["A1"].LoadFromDataTable(dt, true);

                Response.Clear();
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment; filename=AttendanceReport.xlsx");
                Response.BinaryWrite(pck.GetAsByteArray());
                HttpContext.Current.ApplicationInstance.CompleteRequest();
            }
        }

        protected void btnExportPDF_Click(object sender, EventArgs e)
        {
            DataTable dt = GetAttendanceData();
            Document pdfDoc = new Document(PageSize.A4);
            MemoryStream ms = new MemoryStream();
            PdfWriter.GetInstance(pdfDoc, ms);
            pdfDoc.Open();

            PdfPTable table = new PdfPTable(dt.Columns.Count);
            foreach (DataColumn col in dt.Columns)
            {
                table.AddCell(new Phrase(col.ColumnName));
            }
            foreach (DataRow row in dt.Rows)
            {
                foreach (var cell in row.ItemArray)
                {
                    table.AddCell(cell.ToString());
                }
            }
            pdfDoc.Add(table);
            pdfDoc.Close();

            Response.Clear();
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment; filename=AttendanceReport.pdf");
            Response.BinaryWrite(ms.ToArray());
            HttpContext.Current.ApplicationInstance.CompleteRequest();
        }

        private DataTable GetAttendanceData()
        {
            string trainerID = Session["TrainerID"].ToString();
            string connStr = ConfigurationManager.ConnectionStrings["GymDB"].ConnectionString;

            using (MySqlConnection con = new MySqlConnection(connStr))
            {
                string query = @"SELECT m.Name AS MemberName, a.Date, a.Status 
                                FROM Attendance a
                                INNER JOIN Members m ON a.MemberID = m.MemberID
                                WHERE m.TrainerID = @TrainerID
                                ORDER BY a.Date DESC";

                using (MySqlCommand cmd = new MySqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@TrainerID", trainerID);
                    try
                    {
                        con.Open();
                        MySqlDataReader reader = cmd.ExecuteReader();
                        DataTable dt = new DataTable();
                        dt.Load(reader);
                        return dt;
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine("Database Error: " + ex.Message);
                        Response.Write("<script>alert('Database Error: " + ex.Message + "');</script>");
                        return new DataTable();
                    }
                }
            }
        }
    }
}
