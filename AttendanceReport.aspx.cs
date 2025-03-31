using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using ClosedXML.Excel;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.Web;

namespace GYM_MANAGEMENT
{
    public partial class AttendanceReport : Page
    {
        private string connectionString = "server=localhost;database=gymmanagementdb;user=root;password=2004";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtStartDate.Text = DateTime.Today.AddDays(-7).ToString("yyyy-MM-dd");
                txtEndDate.Text = DateTime.Today.ToString("yyyy-MM-dd");
                BindAttendanceGrid();
            }
        }

        protected void btnLoad_Click(object sender, EventArgs e)
        {
            BindAttendanceGrid();
        }

        private void BindAttendanceGrid()
        {
            GridViewAttendance.DataSource = GetAttendanceData();
            GridViewAttendance.DataBind();
        }

        protected void btnExportExcel_Click(object sender, EventArgs e)
        {
            DataTable dt = GetAttendanceData();
            using (XLWorkbook wb = new XLWorkbook())
            {
                var ws = wb.Worksheets.Add("Attendance Report");
                string gymName = "Your Gym Name";
                string reportDate = "Date: " + DateTime.Now.ToString("dd-MM-yyyy");

                ws.Cell("A1").Value = gymName;
                ws.Cell("A1").Style.Font.Bold = true;
                ws.Cell("A1").Style.Font.FontSize = 14;

                ws.Cell("A2").Value = reportDate;
                ws.Cell("A2").Style.Font.Bold = true;
                ws.Cell("A2").Style.Font.FontSize = 12;

                int headerRow = 4;
                for (int i = 0; i < dt.Columns.Count; i++)
                {
                    ws.Cell(headerRow, i + 1).Value = dt.Columns[i].ColumnName;
                    ws.Cell(headerRow, i + 1).Style.Font.Bold = true;
                }

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    for (int j = 0; j < dt.Columns.Count; j++)
                    {
                        ws.Cell(i + 5, j + 1).Value = dt.Rows[i][j].ToString();
                    }
                }

                ws.Columns().AdjustToContents();

                Response.Clear();
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment;filename=AttendanceReport.xlsx");

                using (MemoryStream memoryStream = new MemoryStream())
                {
                    wb.SaveAs(memoryStream);
                    memoryStream.WriteTo(Response.OutputStream);
                    Response.Flush();
                    Response.End();
                }
            }
        }

        protected void btnExportPDF_Click(object sender, EventArgs e)
        {
            DataTable dt = GetAttendanceData();
            if (dt.Rows.Count > 0)
            {
                Document doc = new Document(PageSize.A4);
                MemoryStream memoryStream = new MemoryStream();
                PdfWriter writer = PdfWriter.GetInstance(doc, memoryStream);
                doc.Open();

                string gymName = "Your Gym Name";
                string reportDate = "Date: " + DateTime.Now.ToString("dd-MM-yyyy");

                Paragraph title = new Paragraph(gymName, FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 16));
                title.Alignment = Element.ALIGN_CENTER;
                doc.Add(title);

                Paragraph date = new Paragraph(reportDate, FontFactory.GetFont(FontFactory.HELVETICA, 12));
                date.Alignment = Element.ALIGN_CENTER;
                doc.Add(date);
                doc.Add(new Paragraph("\n"));

                PdfPTable table = new PdfPTable(dt.Columns.Count);
                table.WidthPercentage = 100;

                foreach (DataColumn column in dt.Columns)
                {
                    PdfPCell headerCell = new PdfPCell(new Phrase(column.ColumnName, FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 12)));
                    headerCell.BackgroundColor = new BaseColor(200, 200, 200);
                    table.AddCell(headerCell);
                }

                foreach (DataRow row in dt.Rows)
                {
                    foreach (var item in row.ItemArray)
                    {
                        table.AddCell(new Phrase(item.ToString(), FontFactory.GetFont(FontFactory.HELVETICA, 10)));
                    }
                }

                doc.Add(table);
                doc.Close();

                byte[] bytes = memoryStream.ToArray();
                memoryStream.Close();

                Response.Clear();
                Response.ContentType = "application/pdf";
                Response.AddHeader("content-disposition", "attachment;filename=AttendanceReport.pdf");
                Response.BinaryWrite(bytes);
                Response.End();
            }
        }

        private DataTable GetAttendanceData()
        {
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = @"SELECT m.MemberID, m.Name AS MemberName, a.Date AS AttendanceDate, a.Status AS AttendanceStatus 
                                 FROM attendance a 
                                 JOIN members m ON a.MemberID = m.MemberID 
                                 WHERE a.Date BETWEEN @StartDate AND @EndDate";

                if (!string.IsNullOrEmpty(txtMemberID.Text))
                {
                    query += " AND m.MemberID = @MemberID";
                }
                if (!string.IsNullOrEmpty(txtMemberName.Text))
                {
                    query += " AND m.Name LIKE @MemberName";
                }

                query += " ORDER BY a.Date DESC, m.Name";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@StartDate", txtStartDate.Text);
                    cmd.Parameters.AddWithValue("@EndDate", txtEndDate.Text + " 23:59:59");

                    if (!string.IsNullOrEmpty(txtMemberID.Text))
                    {
                        cmd.Parameters.AddWithValue("@MemberID", txtMemberID.Text);
                    }
                    if (!string.IsNullOrEmpty(txtMemberName.Text))
                    {
                        cmd.Parameters.AddWithValue("@MemberName", "%" + txtMemberName.Text + "%");
                    }

                    MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    return dt;
                }
            }
        }
    }
}
