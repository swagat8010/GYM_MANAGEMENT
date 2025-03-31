using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Mail;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace GYM_MANAGEMENT
{
    public partial class ManagePayments : Page
    {
        private string connectionString = "server=localhost;database=gymmanagementdb;user=root;password=2004";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindPaymentsGrid();
            }
        }

        // Bind payments data to the GridView
        private void BindPaymentsGrid()
        {
            string query = "SELECT * FROM payments";
            List<Payment> payments = new List<Payment>();

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    conn.Open();
                    MySqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        Payment payment = new Payment
                        {
                            PaymentID = reader.GetInt32("PaymentID"),
                            MemberID = reader.GetInt32("MemberID"),
                            Name = reader.GetString("Name"),
                            Amount = reader.GetDecimal("Amount"),
                            PaymentDate = reader.IsDBNull(reader.GetOrdinal("PaymentDate")) ? (DateTime?)null : reader.GetDateTime("PaymentDate"),
                            PaymentMethod = reader.GetString("PaymentMethod")
                        };
                        payments.Add(payment);
                    }
                }
            }
            GridViewPayments.DataSource = payments;
            GridViewPayments.DataBind();
        }

        // Handle row data bound to display payment status based on PaymentMethod
        protected void GridViewPayments_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblStatus = (Label)e.Row.FindControl("lblStatus");
                string paymentMethod = DataBinder.Eval(e.Row.DataItem, "PaymentMethod")?.ToString();

                if (!string.IsNullOrEmpty(paymentMethod) && paymentMethod.Equals("Pending", StringComparison.OrdinalIgnoreCase))
                {
                    lblStatus.Text = "Pending";
                    lblStatus.CssClass = "status-pending";  // Apply red color style
                }
                else
                {
                    lblStatus.Text = "Completed"; // Display "Completed" instead of blank
                    lblStatus.CssClass = "status-completed"; // Apply green color style
                }
            }
        }

        // Handle the button click to notify user
        protected void NotifyButton_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;  // This is now a Button
            int memberID = Convert.ToInt32(btn.CommandArgument);

            // Send payment reminder email
            SendPaymentReminder(memberID);

            // Optionally, show a message on the page
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Notification Sent!');", true);
        }

        // Simulate sending an email or notification
        // Simulate sending an email or notification
        private void SendPaymentReminder(int memberID)
        {
            string memberName = GetMemberName(memberID);  // Fetch the member's name
            string memberEmail = GetMemberEmail(memberID); // Fetch the member's email
            decimal amountDue = GetMemberDueAmount(memberID); // Fetch the member's due amount
            string subject = "💸 Payment Reminder";
            string message = $@"
            
Dear {memberName},

We hope you're enjoying our services. Please note that an outstanding payment of 💰 ${amountDue:F2} is due. Kindly make your payment at the earliest to avoid service disruptions. You can visit our office or use our online payment options.

Thank you for being a valued member! 😊

Best regards,  
Your GYM Management Team
";


            // Call method to send email
            SendEmail(memberEmail, subject, message);
        }

        // Fetch member's name from the database
        private string GetMemberName(int memberID)
        {
            string name = string.Empty;
            string query = "SELECT Name FROM members WHERE MemberID = @MemberID";

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@MemberID", memberID);
                    conn.Open();
                    MySqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        name = reader.GetString("Name");
                    }
                }
            }
            return name;
        }

        // Fetch member's email from the database
        private string GetMemberEmail(int memberID)
        {
            string email = string.Empty;
            string query = "SELECT Email FROM members WHERE MemberID = @MemberID";

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@MemberID", memberID);
                    conn.Open();
                    MySqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        email = reader.GetString("Email");
                    }
                }
            }
            return email;
        }

        // Send an email using SMTP
        private void SendEmail(string toEmail, string subject, string message)
        {
            try
            {
                string fromEmail = "swagatchougule354@gmail.com"; // Replace with your Gmail address
                string fromPassword = "irwe gktf osik txsi"; // Replace with your Gmail password or app-specific password

                SmtpClient smtpClient = new SmtpClient("smtp.gmail.com")
                {
                    Port = 587,  // TLS encryption
                    Credentials = new NetworkCredential(fromEmail, fromPassword),
                    EnableSsl = true
                };

                MailMessage mailMessage = new MailMessage(fromEmail, toEmail, subject, message);

                // Send email
                smtpClient.Send(mailMessage);
            }
            catch (Exception ex)
            {
                // Handle error (e.g., log it)
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error sending email: " + ex.Message + "');", true);
            }
        }
        // Fetch the member's due amount from the database
        private decimal GetMemberDueAmount(int memberID)
        {
            decimal amount = 0;
            string query = "SELECT Amount FROM payments WHERE MemberID = @MemberID AND PaymentMethod = 'Pending'";

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@MemberID", memberID);
                    conn.Open();
                    MySqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        amount = reader.GetDecimal("Amount");
                    }
                }
            }
            return amount;
        }


        // Define the Payment class
        public class Payment
        {
            public int PaymentID { get; set; }
            public int MemberID { get; set; }
            public string Name { get; set; }
            public decimal Amount { get; set; }
            public DateTime? PaymentDate { get; set; }
            public string PaymentMethod { get; set; }
        }
    }
}
